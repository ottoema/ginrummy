from flask import Flask, render_template, request, redirect, url_for, flash
from flask_mysqldb import MySQL
import yaml
from pprint import pprint

app = Flask(__name__)

# Configure db
db = yaml.load(open('db.yaml'),Loader=yaml.CLoader)
app.secret_key = 'afmi3kfnklfmofk231FO#F23ifnqm1;o3f!#f#F13ffi3nlfn3kl2fm23klf'
app.config['MYSQL_HOST'] = db['mysql_host']
app.config['MYSQL_USER'] = db['mysql_user']
app.config['MYSQL_PASSWORD'] = db['mysql_password']
app.config['MYSQL_DB'] = db['mysql_db']

mysql = MySQL(app)

@app.route('/')
def index():
    return render_template('index.html')

@app.route('/games')
def games():    
    cur = mysql.connection.cursor()

    resultValue = cur.execute("CALL get_all_players;")
    playerDetails = cur.fetchall()
    resultValue = cur.execute("CALL get_list_of_games;")
    gameDetails = cur.fetchall()
    return render_template('games.html',gameDetails=gameDetails,playerDetails=playerDetails)

@app.route('/gameboard', methods=['GET', 'POST'])
def gameboard():
    game_id = -1
    gamerun_data  = request.form
    cur = mysql.connection.cursor()
    if request.method == "POST":
        
        finished = (int(gamerun_data["finished"]) == 1)
        game_id = int(gamerun_data["game"])
        run = int(gamerun_data["run"])

        cur.callproc("create_new_game_run",[game_id,0])
        cur.execute("""SELECT @_create_new_game_run_1""")
        gamerun_id = cur.fetchall()[0][0]
        mysql.connection.commit()

        anfang = "score-r" + str(run) + "-p"
        gen = [field for field in request.form.items() if field[0].startswith(anfang)]
        for player_field, score_field in gen:
            player_id = int(player_field.split(anfang)[1])
            score = int(score_field)
            print ("Reporting " + str(score) + " points for player_id " + str(player_id ))
            cur.callproc("add_score_to_gamerun",[gamerun_id,game_id,player_id,score])
            mysql.connection.commit()

        if (finished):
            cur.callproc("finish_game",[game_id,0,''])
            cur.execute("""SELECT @_finish_game_1,@_finish_game_2""")
            winner_name = str(cur.fetchall()[0][1])
            mysql.connection.commit()
            flash("Congratulations %s!" % winner_name)

    elif request.method == "GET":
        game_id = int(request.args.get("game"))
    cur.execute("CALL get_players_in_game(%d)" % game_id)
    player_order = cur.fetchall()
    cur.execute("CALL get_game_score(%d)" % game_id)
    game_score = cur.fetchall()
    cur.execute("CALL get_all_targets()")
    game_targets = cur.fetchall()
    cur.close()
    return render_template('gameboard.html',game=game_id,order=player_order,score=game_score,targets=game_targets)

@app.route('/players')
def players():
    cur = mysql.connection.cursor()
    resultValue = cur.execute("CALL get_all_players;")
    playerDetails = cur.fetchall()
    return render_template('players.html',playerDetails=playerDetails)

@app.route('/insert_player', methods = ['POST'])
def insert_player():

    if request.method == "POST":
        flash("Data Inserted Successfully")
        name = request.form['name']
        cur = mysql.connection.cursor()
        args = [name,0]
        result_args = cur.callproc("add_new_player",args)
        mysql.connection.commit()
        cur.close()
        return redirect(url_for('players'))

@app.route('/add_new_player', methods=['GET', 'POST'])
def add_players():
    if request.method == 'POST':
        # Fetch form data
        playerData = request.form
        name = playerData['name']
        cur = mysql.connection.cursor()
        args = [name,0,0]
        cur.callproc("add_new_player",args)
        mysql.connection.commit()
        cur.close()
        return redirect('/players')
    return render_template('add_new_player.html')

@app.route('/start_new_game', methods=['GET', 'POST'])
def start_new_game():
    if request.method == 'POST':
        players = list(request.values['order_of_players'][1:].split(","))
        if (len(players) < 2):
            return render_template('error.html')
    
        cur = mysql.connection.cursor()
        cur.callproc("create_new_game",[0])
        cur.execute("""SELECT @_create_new_game_0""")
        result = cur.fetchall()
        mysql.connection.commit()
        game_id = int(result[0][0])

        for player in players:
            cur.callproc("add_player_to_game",[player,game_id])
            mysql.connection.commit()
        

        return redirect(url_for('gameboard',game=game_id))

if __name__ == '__main__':
    app.run(debug=True)