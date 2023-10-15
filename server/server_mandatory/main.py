import time
import random
from flask import Flask,request, render_template
from flask_cors import CORS
import sqlite3
import json
import requests
import hashlib
def hash(str):
  sha256_hash = hashlib.sha256()
  sha256_hash.update(str.encode('utf-8'))
  hashed_string = sha256_hash.hexdigest()
  return hashed_string
conDB=sqlite3.connect("auth.db",check_same_thread=False)
cur=conDB.cursor()
app=Flask(__name__)
CORS(app)

#server logic public


'''
table = {
email=value,
firstName=value,
lastName=value,
password=value,
}
'''

#server logic no public
@app.route("/checks",methods=["GET","POST"])
def default():
  if request.method=="GET":
    return "accept",200
  else:
    return "sorry",403
@app.route("/registers",methods=["POST"]) 
def register():
  '''
  {
  "email": "email",
  "firstName": "firstName",
  "lastName": "lastName",
  "password": "password"
  }
  '''
  dictReg=json.loads(request.data)
  email=dictReg["email"].strip()
  firstName=dictReg["firstName"].strip()
  lastName=dictReg["lastName"].strip()
  password=hash(dictReg["password"].strip())
  cur.execute("""SELECT email FROM auth WHERE email='%s' and password='%s'"""%(email,password))
  if(cur.fetchone()!=None):
    return "existed",406
  cur.execute("""INSERT INTO auth VALUES('%s','%s','%s','%s')"""%(email,firstName,lastName,password))
  conDB.commit()
  return "ok",200
  
@app.route("/logins",methods=["POST"])
def login():
  '''
  {
  "email": "email",
  "password": "password"
  }
  '''
  dictReg=json.loads(request.data)
  email=dictReg["email"].strip()
  password=hash(dictReg["password"].strip())
  cur.execute("""SELECT email FROM auth WHERE email='%s' and password='%s'"""%(email,password))
  if(cur.fetchone()!=None):
    return "ok",200
  return "not existed",406
@app.route("/accesDBs",methods=["POST"])
def accesDB():
  '''
  {command:command}
  '''
  command=json.loads(request.data)
  cur.execute(command["command"])
  res=cur.fetchall()
  
  return str(res),200
app.run(host="0.0.0.0",port=8080)