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


# CRIAR TAREFA
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

		# Execute query
		query = ("INSERT INTO task (description, difficulty) VALUES (%s, %s);")
		data = (json["description"], json["difficulty"])
		cursor.execute(query, data)

		# Return success
		return jsonify({"status": "success!"})

	except Exception as e:
		return jsonify({"status": "nok"})

	finally:
		dbConn.commit()
		cursor.close()
		dbConn.close()


# ATRIBUIR TAREFA
@app.route('/createAssignment', methods=["POST"])
def createAssignment():
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

		# Execute query
		query = ("INSERT INTO assignment (agent, task, start_date, deadline_date, supervisor, reward) VALUES (%s, %s, %s, %s, %s, %s);")
		data = (json["agent"], json["task"], json["start_date"], json["deadline_date"], json["supervisor"], json["reward"])
		cursor.execute(query, data)

		# Return success
		return jsonify({"status": "ok"})

	except Exception as e:
		return jsonify({"status": "nok"})

	finally:
		dbConn.commit()
		cursor.close()
		dbConn.close()


# ACABAR TAREFA
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

		# Execute query
		query = ("UPDATE assignment SET status = 'feito' WHERE id = %s;")
		data = (json["id"],)
		cursor.execute(query, data)

		# Response query
		query = ("SELECT json_agg(tasks) FROM (SELECT * FROM assignment WHERE agent = (select agent from assignment where id = %s) order by id desc) as tasks;")
		cursor.execute(query, data)

		# Return new assignment list
		json_response = str(cursor.fetchone())[1:-1]
		return jsonify(eval(json_response))

	except Exception as e:
		return jsonify({"status": "nok"})

	finally:
		dbConn.commit()
		cursor.close()
		dbConn.close()


# RECLAMAR TAREFA
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

		# Execute query
		query = ("UPDATE assignment SET status = 'em consideração' WHERE id = %s;")
		data = (json["id"],)
		cursor.execute(query, data)

		# Response query
		query = ("SELECT json_agg(tasks) FROM (SELECT * FROM assignment WHERE agent = (select agent from assignment where id = %s) order by id desc) as tasks;")
		cursor.execute(query, data)

		# Return new assignment list
		json_response = str(cursor.fetchone())[1:-1]
		return jsonify(eval(json_response))

	except Exception as e:
		return jsonify({"status": "nok"})

	finally:
		dbConn.commit()
		cursor.close()
		dbConn.close()


# LISTAR TAREFAS POR FILHO
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

		# Execute query
		query = ("SELECT json_agg(tasks) FROM (SELECT * FROM assignment WHERE agent = %s order by id desc) as tasks;")
		data = (json["agent"],)
		cursor.execute(query, data)

		# Return assignments list
		json_response = str(cursor.fetchone())[1:-1]
		return jsonify(eval(json_response))

	except Exception as e:
		return jsonify({"status": "nok"})

	finally:
		cursor.close()
		dbConn.close()


# LISTAR NOTICIAS POR SUPERVISOR
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

		# Execute query
		query = ("SELECT json_agg(list) FROM (SELECT * FROM news WHERE supervisor = %s order by id desc) as list;")
		data = (json["supervisor"],)
		cursor.execute(query, data)

		# Return news list
		json_response = str(cursor.fetchone())[1:-1]
		return jsonify(eval(json_response))

	except Exception as e:
		return jsonify({"status": "nok"})

	finally:
		cursor.close()
		dbConn.close()


# MARCAR NOTICIA COMO LIDA
@app.route('/checkNews', methods=["POST"])
def checkNews():
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

		# Check news
		query = ("UPDATE news SET status = 'visto' WHERE id = %s;")
		data = (json["id"],)
		cursor.execute(query, data)

		# Response query
		query = ("SELECT json_agg(list) FROM (SELECT * FROM news WHERE supervisor = (select supervisor from news where id = %s) order by id desc) as list;")
		cursor.execute(query, data)

		# Return new news list
		json_response = str(cursor.fetchone())[1:-1]
		return jsonify(eval(json_response))

	except Exception as e:
		return jsonify({"status": "nok"})

	finally:
		cursor.close()
		dbConn.close()


# FORÇAR TAREFA
@app.route('/forceAssignment', methods=["POST"])
def forceAssignment():
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

		# Force assignment
		query = ("UPDATE assignment SET status = 'por fazer' WHERE id = %s;")
		data = (json["assignment_id"],)
		cursor.execute(query, data)

		# Check news
		query = ("UPDATE news SET status = 'visto' WHERE id = %s;")
		data = (json["news_id"],)
		cursor.execute(query, data)

		# Response
		query = ("SELECT json_agg(list) FROM (SELECT * FROM news WHERE supervisor = (select supervisor from news where id = %s) order by id desc) as list;")
		data = (json["news_id"],)
		cursor.execute(query, data)

		# Return new news list
		json_response = str(cursor.fetchone())[1:-1]
		return jsonify(eval(json_response))

	except Exception as e:
		return jsonify({"status": "nok"})

	finally:
		cursor.close()
		dbConn.close()


# ESQUECER TAREFA
@app.route('/forgetAssignment', methods=["POST"])
def forgetAssignment():
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

		# Forget assignment
		query = ("DELETE FROM assignment WHERE id = %s;")
		data = (json["assignment_id"],)
		cursor.execute(query, data)

		# Check news
		query = ("UPDATE news SET status = 'visto' WHERE id = %s;")
		data = (json["news_id"],)
		cursor.execute(query, data)

		# Response
		query = ("SELECT json_agg(list) FROM (SELECT * FROM news WHERE supervisor = (select supervisor from news where id = %s) order by id desc) as list;")
		data = (json["news_id"],)
		cursor.execute(query, data)

		# Return new news list
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

		# Execute query
		query = ("SELECT json_agg(scores) FROM (SELECT name, score from agent ORDER BY score DESC) as scores;")
		cursor.execute(query)

		# Return scores
		json_response = str(cursor.fetchone())[1:-1]
		return jsonify(eval(json_response))

	except Exception as e:
		return jsonify({"status": "nok"})

	finally:
		cursor.close()
		dbConn.close()

## Flask Handler
CGIHandler().run(app)