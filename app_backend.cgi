#!/usr/bin/python3

# -----------------------------------------------------------------------------------------
#																 HOUSEHOLD CHORES BACKEND
#
#						created: 			 20/12/2020
#						last modified: 23/12/2020
#						by: 				 	 Diogo
#
#						Description:	 Flask connects to and queries database at db.tecnico.ulisboa.pt.
#													 Gets requests from and replies to frontend using REST API.
#						
#						Frontend frameworks suggestions: React Native, Flutter (both cross platform).
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
@app.route('/criarTarefa', methods=["POST"])
def criarTarefa():
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
		query = ("INSERT INTO tarefa (descricao, criador, dificuldade) VALUES (%s, %s);")
		data = (json["descricao"], json["criador"], json["dificuldade"])

		# Execute and return
		cursor.execute(query, data)
		return jsonify({"status": "tarefa criada"})

	except Exception as e:
		return jsonify({"status": "nok"})

	finally:
		dbConn.commit()
		cursor.close()
		dbConn.close()


# ATRIBUIR TAREFA
@app.route('/atribuirTarefa', methods=["POST"])
def atribuirTarefa():
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
		query = ("INSERT INTO realiza (filho, tarefa, data_conclusao, supervisor) VALUES (%s, %s, %s, %s);")
		data = (json["filho"], json["tarefa"], json["data_conclusao"], json["supervisor"])

		# Execute and return
		cursor.execute(query, data)
		return jsonify({"status": "ok"})

	except Exception as e:
		return jsonify({"status": "nok"})

	finally:
		dbConn.commit()
		cursor.close()
		dbConn.close()


# LISTAR TAREFAS POR FILHO
@app.route('/listarTarefasPorFilho', methods=["POST"])
def listarTarefas():
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
		query = ("SELECT json_agg(*) FROM realiza WHERE filho = %s;")
		data = (json["filho"],)

		# Execute and return
		cursor.execute(query, data)
		return jsonify(cursor.fetchall())

	except Exception as e:
		return jsonify({"status": "nok"})

	finally:
		cursor.close()
		dbConn.close()


# ALTERAR STATUS DE TAREFA
@app.route('/alterarStatusTarefa', methods=["POST"])
def alterarStatusTarefa():
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
		query = ("UPDATE realiza SET status = %s WHERE id = %s;")
		data = (json["status"], json["id"])

		# Execute and return
		cursor.execute(query, data)
		return jsonify({"status": "ok"})

	except Exception as e:
		return jsonify({"status": "nok"})

	finally:
		dbConn.commit()
		cursor.close()
		dbConn.close()


# LISTAR PONTUACAO
@app.route('/listarPontuacao', methods=["GET"])
def listarPontuacao():
	dbConn = None
	cursor = None
	try:
		# Connect to db
		dbConn = psycopg2.connect(DB_CONNECTION_STRING)
		cursor = dbConn.cursor(cursor_factory=psycopg2.extras.DictCursor)

		# Prepare query
		query = ("SELECT json_agg(nome, pontuacao) FROM filho ORDER BY pontuacao DESC;")

		# Execute and return
		cursor.execute(query)
		return jsonify(cursor.fetchall())

	except Exception as e:
		return jsonify({"status": "nok"})

	finally:
		cursor.close()
		dbConn.close()

## Flask Handler
CGIHandler().run(app)