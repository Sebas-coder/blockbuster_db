from flask import Flask, jsonify
from conection import conection
import os
app = Flask(__name__)

@app.route("/")
def main():
    return jsonify({ "MESSAGE" : "MIA Practica 1" })

@app.route("/conteos")
def getConteos():
    conexion = conection()
    consulta = conexion.conteos();
    return jsonify({ "NAME": "Consulta 1", "QUERY":consulta})

@app.route("/consulta1")
def getConsulta1():
    conexion = conection()
    consulta = conexion.consulta1();
    return jsonify({ "NAME": "Consulta 1", "QUERY":consulta})

@app.route("/consulta2")
def getConsulta2():
    conexion = conection()
    consulta = conexion.consulta2();
    return jsonify({ "NAME": "Consulta 2", "QUERY":consulta})

@app.route("/consulta3")
def getConsulta3():
    conexion = conection()
    consulta = conexion.consulta3();
    return jsonify({ "NAME": "Consulta 3", "QUERY":consulta})

@app.route("/consulta4")
def getConsulta4():
    conexion = conection()
    consulta = conexion.consulta4();
    return jsonify({ "NAME": "Consulta 4", "QUERY":consulta})

@app.route("/consulta5")
def getConsulta5():
    conexion = conection()
    consulta = conexion.consulta5();
    return jsonify({ "NAME": "Consulta 5", "QUERY":consulta})

@app.route("/consulta6")
def getConsulta6():
    conexion = conection()
    consulta = conexion.consulta6();
    return jsonify({ "NAME": "Consulta 6", "QUERY":consulta})

@app.route("/consulta7")
def getConsulta7():
    conexion = conection()
    consulta = conexion.consulta7();
    return jsonify({ "NAME": "Consulta 7", "QUERY":consulta})

@app.route("/consulta8")
def getConsulta8():
    conexion = conection()
    consulta = conexion.consulta8();
    return jsonify({ "NAME": "Consulta 8", "QUERY":consulta})

@app.route("/consulta9")
def getConsulta9():
    conexion = conection()
    consulta = conexion.consulta9();
    return jsonify({ "NAME": "Consulta 9", "QUERY":consulta})

@app.route("/consulta10")
def getConsulta10():
    conexion = conection()
    consulta = conexion.consulta10();
    return jsonify({ "NAME": "Consulta 10", "QUERY":consulta})

@app.route("/eliminarTemporal")
def geteliminarTemporal():
    conexion = conection()
    consulta = conexion.eliminarTemporal();
    return jsonify({ "NAME": "Eliminar Temporal", "RESULT":consulta})

@app.route("/eliminarModelo")
def geteliminarModelo():
    conexion = conection()
    consulta = conexion.eliminarModelo();
    return jsonify({ "NAME": "Eliminar modelo", "RESULT":'Modelo eliminado correctamente'})

@app.route("/cargarTemporal")
def getcargaTemporal():
    conexion = conection()
    consulta = conexion.cargaTemporal();
    return jsonify({ "NAME": "Carga de temporal", "RESULT":'Temporal cargado correctamente'})

@app.route("/cargarModelo")
def getcargaModelo():
    conexion = conection()
    consulta = conexion.cargaModelo();
    return jsonify({ "NAME": "Carga de Modelo", "RESULT":'Modelo cargado correctamente'})

if __name__ == '__main__':
    app.run(debug=True, port=4000)