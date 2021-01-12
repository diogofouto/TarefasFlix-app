#!/usr/bin/python3

# -----------------------------------------------------------------------------------------
#																 HOUSEHOLD CHORES BACKEND
#
#			created: 			 20/12/2020
#			last modified: 23/12/2020
#			by: 				 	 Diogo
#
#			Description:	 Flask connects to and queries database at db.tecnico.ulisboa.pt.
#							 Gets requests from and replies to frontend using REST API.
#						
#			Frontend frameworks suggestions: React Native, Flutter (both cross platform).
# -----------------------------------------------------------------------------------------

## Flask libs
from wsgiref.handlers import CGIHandler
from flask import Flask, request, jsonify

## PostgreSQL libs
import psycopg2
import psycopg2.extras

## SGBD configs
DB_HOST="db.tecnico.ulisboa.pt"
DB_USER="ist193705"
DB_DATABASE=DB_USER
DB_PASSWORD="Atleta2000"
DB_CONNECTION_STRING = "host=%s dbname=%s user=%s password=%s" % (DB_HOST, DB_DATABASE, DB_USER, DB_PASSWORD)


## Flask app
app = Flask(__name__)


# DEBUG
@app.route('/')
def debug():
	try:
		return jsonify({"debug": "working!"})
	except Exception as e:
		return jsonify({"status": "nok"})


# CRIAR task
@app.route('/createTask', methods=["POST"])
def createTask():
	dbConn=None
	cursor=None

	try:
		# Connect to db
		dbConn = psycopg2.connect(DB_CONNECTION_STRING)
		cursor = dbConn.cursor(cursor_factory = psycopg2.extras.DictCursor)

		# Get data
		json = request.get_json()
		if len(json) == 0:
				return jsonify({"status": "nok"})

		# Prepare query
		query = ("INSERT INTO task (description, difficulty) VALUES (%s, %s);")
		data = (json["description"], json["difficulty"])

		# Execute and return
		cursor.execute(query, data)
		return jsonify({"status": "success!"})

	except Exception as e:
		return jsonify({"status": "nok"})

	finally:
		dbConn.commit()
		cursor.close()
		dbConn.close()


# ATRIBUIR task
@app.route('/assignTask', methods=["POST"])
def assignTask():
	dbConn=None
	cursor=None

	try:
		# Connect to db
		dbConn = psycopg2.connect(DB_CONNECTION_STRING)
		cursor = dbConn.cursor(cursor_factory = psycopg2.extras.DictCursor)

		# Get data
		json = request.get_json()
		if len(json) == 0:
				return jsonify({"status": "nok"})

		# Prepare query
		query = ("INSERT INTO assignment (agent, task, deadline_date, supervisor) VALUES (%s, %s, %s, %s);")
		data = (json["agent"], json["task"], json["deadline_date"], json["supervisor"])

		# Execute and return
		cursor.execute(query, data)
		return jsonify({"status": "ok"})

	except Exception as e:
		return jsonify({"status": "nok"})

	finally:
		dbConn.commit()
		cursor.close()
		dbConn.close()


# ALTERAR STATUS DE task
@app.route('/finishAssignment', methods=["POST"])
def finishAssignment():
	dbConn=None
	cursor=None

	try:
		# Connect to db
		dbConn = psycopg2.connect(DB_CONNECTION_STRING)
		cursor = dbConn.cursor(cursor_factory = psycopg2.extras.DictCursor)

		# Get data
		json = request.get_json()
		if len(json) == 0:
				return jsonify({"status": "nok"})

		# Prepare query
		query = ("UPDATE assignment SET status = 'feito' WHERE id = %s;")
		data = (json["id"],)

		cursor.execute(query, data)

		# Prepare response query
		query = ("SELECT json_agg(tasks) FROM (SELECT * FROM assignment WHERE agent = (select agent from assignment where id = %s)) as tasks;")

		# Execute and return
		cursor.execute(query, data)
		json_response = str(cursor.fetchone())[1:-1]
		return jsonify(eval(json_response))

	except Exception as e:
		return jsonify({"status": "nok"})

	finally:
		dbConn.commit()
		cursor.close()
		dbConn.close()


# ALTERAR STATUS DE task
@app.route('/complainAssignment', methods=["POST"])
def complainAssignment():
	dbConn=None
	cursor=None

	try:
		# Connect to db
		dbConn = psycopg2.connect(DB_CONNECTION_STRING)
		cursor = dbConn.cursor(cursor_factory = psycopg2.extras.DictCursor)

		# Get data
		json = request.get_json()
		if len(json) == 0:
				return jsonify({"status": "nok"})

		# Prepare query
		query = ("UPDATE assignment SET status = 'em consideração' WHERE id = %s;")
		data = (json["id"],)

		cursor.execute(query, data)

		# Prepare response query
		query = ("SELECT json_agg(tasks) FROM (SELECT * FROM assignment WHERE agent = (select agent from assignment where id = %s)) as tasks;")

		# Execute and return
		cursor.execute(query, data)
		json_response = str(cursor.fetchone())[1:-1]
		return jsonify(eval(json_response))

		# Execute and return
		cursor.execute(query, data)
		return jsonify({"status": "success!"})

	except Exception as e:
		return jsonify({"status": "nok"})

	finally:
		dbConn.commit()
		cursor.close()
		dbConn.close()


# LISTAR taskS POR FILHO
@app.route('/askAssignment', methods=["POST"])
def askAssignment():
	dbConn = None
	cursor = None
	try:
		# Connect to db
		dbConn = psycopg2.connect(DB_CONNECTION_STRING)
		cursor = dbConn.cursor(cursor_factory=psycopg2.extras.DictCursor)

		# Get data
		json = request.get_json()
		if len(json) == 0:
				return jsonify({"status": "nok"})

		# Prepare query
		query = ("insert into news (agent, task, supervisor, message) values (%s, %s, %s, 'Quero mais!');")
		data = (json["agent"], json["task"], json["supervisor"])

		# Execute and return
		cursor.execute(query, data)
		return jsonify({"status": "success!"})

	except Exception as e:
		return jsonify({"status": "nok"})

	finally:
		cursor.close()
		dbConn.close()


# LISTAR taskS POR FILHO
@app.route('/listAssignments', methods=["POST"])
def listAssignments():
	dbConn = None
	cursor = None
	try:
		# Connect to db
		dbConn = psycopg2.connect(DB_CONNECTION_STRING)
		cursor = dbConn.cursor(cursor_factory=psycopg2.extras.DictCursor)

		# Get data
		json = request.get_json()
		if len(json) == 0:
				return jsonify({"status": "nok"})

		# Prepare query
		query = ("SELECT json_agg(tasks) FROM (SELECT * FROM assignment WHERE agent = %s) as tasks;")
		data = (json["agent"],)

		# Execute and return
		cursor.execute(query, data)
		json_response = str(cursor.fetchone())[1:-1]
		return jsonify(eval(json_response))

	except Exception as e:
		return jsonify({"status": "nok"})

	finally:
		cursor.close()
		dbConn.close()


# LISTAR taskS POR FILHO
@app.route('/listNews', methods=["POST"])
def listNews():
	dbConn = None
	cursor = None
	try:
		# Connect to db
		dbConn = psycopg2.connect(DB_CONNECTION_STRING)
		cursor = dbConn.cursor(cursor_factory=psycopg2.extras.DictCursor)

		# Get data
		json = request.get_json()
		if len(json) == 0:
				return jsonify({"status": "nok"})

		# Prepare query
		query = ("SELECT json_agg(list) FROM (SELECT * FROM news WHERE supervisor = %s) as list;")
		data = (json["supervisor"],)

		# Execute and return
		cursor.execute(query, data)
		json_response = str(cursor.fetchone())[1:-1]
		return jsonify(eval(json_response))

	except Exception as e:
		return jsonify({"status": "nok"})

	finally:
		cursor.close()
		dbConn.close()


# LISTAR PONTUACAO
@app.route('/listScores', methods=["GET"])
def listScores():
	dbConn = None
	cursor = None
	try:
		# Connect to db
		dbConn = psycopg2.connect(DB_CONNECTION_STRING)
		cursor = dbConn.cursor(cursor_factory=psycopg2.extras.DictCursor)

		# Prepare query
		query = ("SELECT json_agg(scores) FROM (SELECT name, score from agent ORDER BY score DESC) as scores;")

		# Execute and return
		cursor.execute(query)
		json_response = str(cursor.fetchone())[1:-1]
		return jsonify(eval(json_response))

	except Exception as e:
		return jsonify({"status": "nok"})

	finally:
		cursor.close()
		dbConn.close()

## Flask Handler
CGIHandler().run(app)