import psycopg2 
from ddlScript import *
from cargaScript import *
from reporteriaScript import *

class conection():
    def __init__(self):
        self.conexion = psycopg2.connect(database="blockbuster", user="sebas", password="1234")
        self.cursor = self.conexion.cursor()
    
    def eliminarTemporal(self):
        query = {}
        
        try:
            sql = ELIMINAR_TEMPORAL 
            self.cursor.execute(sql)
            query['STATE'] = {
                'NAME':'Successful',
                'MESSAGE': str(self.cursor.statusmessage)
            }
        except Exception as e:
            query['Estado'] = {
                'STATE':'Error',
                'MESSAGE':str(e)
            }
        return query
    
    def eliminarModelo(self):
        query = {}
        
        try:
            sql = ELIMINAR_MODELO 
            self.cursor.execute(sql)
            query['STATE'] = {
                'NAME':'Successful',
                'MESSAGE': str(self.cursor.statusmessage)
            }
        except Exception as e:
            query['Estado'] = {
                'STATE':'Error',
                'MESSAGE':str(e)
            }
        return query
    
    def cargaTemporal(self):
        query = {}
        
        try:
            sql = CARGAR_TEMPORAL 
            self.cursor.execute(sql)
            query['STATE'] = {
                'NAME':'Successful',
                'MESSAGE': 'Carga a tabla temporal exitosa'
            }
        except Exception as e:
            query['Estado'] = {
                'STATE':'Error',
                'MESSAGE':str(e)
            }
        return query
    
    def cargaModelo(self):
        query = {}
        
        try:
            sql = CARGA_MASIVA 
            self.cursor.execute(sql)
            query['STATE'] = {
                'NAME':'Successful',
                'MESSAGE': 'Carga masiva exitosa!'
            }
        except Exception as e:
            query['Estado'] = {
                'STATE':'Error',
                'MESSAGE':str(e)
            }
        return query
    
    
    def consulta1(self):  
        query = {}  
        try:
            sql = CONSULTA1 
            self.cursor.execute(sql)
            
            count = 0
            for dato in self.cursor:
                query[count] = {
                    'Disponibles':dato[0],
                    'Codigo postal':dato[1]
                }
                count += 1
        except Exception as e:
            query['Estado'] = {
                'STATE':'Error',
                'MESSAGE':str(e)
            }
        return query
    
    def consulta2(self):  
        query = {}  
        try:
            sql = CONSULTA2 
            self.cursor.execute(sql)
            
            count = 0
            # Decimal('195.58')
            for dato in self.cursor:
                query[count] = {
                    'Nombre':dato[0],
                    'Apellido':dato[1],
                    'Monto total': str(dato[2]),
                    'Rentas':dato[3]
                }
                count += 1
        except Exception as e:
            query['Estado'] = {
                'STATE':'Error',
                'MESSAGE':str(e)
            }
        return query
    
    def consulta3(self):  
        query = {}  
        try:
            sql = CONSULTA3 
            self.cursor.execute(sql)
            
            count = 0
            for dato in self.cursor:
                query[count] = {
                    'Nombre':dato[0]
                }
                count += 1
        except Exception as e:
            query['Estado'] = {
                'STATE':'Error',
                'MESSAGE':str(e)
            }
        return query
    
    def consulta4(self):  
        query = {}  
        try:
            sql = CONSULTA4 
            self.cursor.execute(sql)
            
            count = 0
            for dato in self.cursor:
                query[count] = {
                    'Nombre':dato[0]
                }
                count += 1
        except Exception as e:
            query['Estado'] = {
                'STATE':'Error',
                'MESSAGE':str(e)
            }
        return query
   
    def consulta5(self):  
        query = {}  
        try:
            sql = CONSULTA5 
            self.cursor.execute(sql)
            
            count = 0
            for dato in self.cursor:
                query[count] = {
                    'Pais':dato[0],
                    'Nombre':dato[1],
                    'Apellido':dato[2],
                    'Porcentaje':dato[3],
                }
                count += 1
        except Exception as e:
            query['Estado'] = {
                'STATE':'Error',
                'MESSAGE':str(e)
            }
        return query
    
    def consulta6(self):  
        query = {}  
        try:
            sql = CONSULTA6 
            self.cursor.execute(sql)
            
            count = 0
            for dato in self.cursor:
                query[count] = {
                    'Pais':dato[0],
                    'Ciudad':dato[1],
                    'Porcentaje':dato[2]
                }
                count += 1
        except Exception as e:
            query['Estado'] = {
                'STATE':'Error',
                'MESSAGE':str(e)
            }
        return query
    
    def consulta7(self):  
        query = {}  
        try:
            sql = CONSULTA7 
            self.cursor.execute(sql)
            
            count = 0
            for dato in self.cursor:
                query[count] = {
                    'Pais':dato[0],
                    'Ciudad':dato[1],
                    'Total ciudad':dato[2],
                    'Total pais':dato[3],
                    'Porcentaje':dato[4]
                }
                count += 1
        except Exception as e:
            query['Estado'] = {
                'STATE':'Error',
                'MESSAGE':str(e)
            }
        return query
    
    def consulta8(self):  
        query = {}  
        try:
            sql = CONSULTA8 
            self.cursor.execute(sql)
            
            count = 0
            for dato in self.cursor:
                query[count] = {
                    'Pais':dato[0],
                    'Categoria':dato[1],
                    'Porcentaje':dato[2]
                }
                count += 1
        except Exception as e:
            query['Estado'] = {
                'STATE':'Error',
                'MESSAGE':str(e)
            }
        return query
    
    def consulta9(self):  
        query = {}  
        try:
            sql = CONSULTA9 
            self.cursor.execute(sql)
            
            count = 0
            for dato in self.cursor:
                query[count] = {
                    'Pais':dato[0],
                    'Ciudad':dato[1],
                    'Numero de rentas':dato[2]
                }
                count += 1
        except Exception as e:
            query['Estado'] = {
                'STATE':'Error',
                'MESSAGE':str(e)
            }
        return query
    
    def consulta10(self):  
        query = {}  
        try:
            sql = CONSULTA10 
            self.cursor.execute(sql)
            
            count = 0
            for dato in self.cursor:
                query[count] = {
                    'Pais':dato[0],
                    'Ciudad':dato[1]
                }
                count += 1
        except Exception as e:
            query['Estado'] = {
                'STATE':'Error',
                'MESSAGE':str(e)
            }
        return query
    
if __name__ == '__main__':
    c = conection()
    c.consulta10()