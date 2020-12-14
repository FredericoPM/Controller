import paho.mqtt.client as mqtt
import mysql.connector

con = mysql.connector.connect(host='localhost', database='tp2iot',user='root',password='4r5t6y7u')

def on_connect(client, userdata, flags, rc):
    print("Connectado" if str(rc) == '0' else "Erro ao conectar")
    createTable = """
        CREATE TABLE tela(
            ID_Tela int unsigned not null,
            Tipo_Tela smallint unsigned not null,
            Light_State int,
            RGB_State char(15),
            Light_State_Slider float,
            constraint PK_TELA primary key (ID_Tela)
        );  
    """
    cursor = con.cursor()
    # este par try/except verifica se a tabeja  já está criada. Se a tabela não existe, cai no try e é criada
    # se existe, cai no except e só mostra a mensagem que  a tabela existe
    try:
        cursor.execute(createTable)
    except:
        print("Tabela dadosIoT já existe.")
        pass
    cursor.close()

def on_message(client, userdata, msg):
    data = str(msg.payload.decode())
    # A mensagem recebida ser o formato ID_Tela|State
    print("Mensagem recebida pelo MQTT:"+ data)
    # Separa o ID_Tela do State
    posicao = data.find('|')
    ID_Tela = data[0:posicao]
    state = data[posicao + 1:len(data)]
    # Caso o indicador seja igual a -1 o dado indica algo lingado ou desligando ou um slider, caso contrario indica um dado rgb
    indcadorVirgula = state.find(',')
    # Caso o indicador seja igual a -1 o dado indica algo lingado ou desligando ou um rgb, caso contrario indica um dado de slider
    indicadorPonto = state.find('.')
    if con.is_connected():
        cursor = con.cursor()
        cursor.execute("SELECT * FROM tp2iot.tela WHERE ID_Tela = " + ID_Tela + ";")
        existe = str(cursor.fetchone())
        # Caso o dado nao existe faz a inserção caso contrario faz o update do dado com o id solicitado
        if(existe == "None"):
            try:
                if(indicadorPonto != -1):
                    cursor.execute("INSERT INTO tp2iot.tela (ID_Tela, Tipo_Tela, Light_State_Slider) VALUES (" + ID_Tela + ", 3," + state + ");")
                elif(indcadorVirgula != -1):
                    cursor.execute("INSERT INTO tp2iot.tela (ID_Tela, Tipo_Tela, RGB_State, Light_State) VALUES (" + ID_Tela + ", 1,'" + state + "', 0);")
                else:
                    cursor.execute("INSERT INTO tp2iot.tela (ID_Tela, Tipo_Tela, Light_State) VALUES (" + ID_Tela + ", 2," + state + ");")
            except NameError:
                print("Ocorreu o seguinte erro: "+ NameError)
                pass
        elif(indcadorVirgula != -1):
            cursor.execute("UPDATE tp2iot.tela SET RGB_State = '" + state + "' WHERE ID_Tela = " + ID_Tela + ";")
            cursor.execute("UPDATE tp2iot.tela SET Tipo_Tela = 1 WHERE ID_Tela = " + ID_Tela + ";")
        elif(indicadorPonto != -1):
            cursor.execute("UPDATE tp2iot.tela SET Light_State_Slider = " + state + " WHERE ID_Tela = " + ID_Tela + ";")
        else:
            try:
                cursor.execute("UPDATE tp2iot.tela SET Light_State = " + state + " WHERE ID_Tela = " + ID_Tela + ";")
            except:
                print("Erro ao editar a linha")
                pass
        # Conta quantos elementos estao pressentes na tabela (a quantidade vem no seguinte formato: (quant,))e separa a quantidade
        cursor.execute("SELECT COUNT(*) FROM tp2iot.tela;")
        quantidade = str(cursor.fetchone())
        virgulaPos = quantidade.find(',')
        quantidade = int(quantidade[1:virgulaPos])
        # Seleciona todos os elementos e todas as colunas da tabela
        cursor.execute("SELECT * FROM tp2iot.tela;")
        # Imprime cada elemento na tela apos a mudança
        for i in range(quantidade):
            linha = cursor.fetchone()
            print("Linha " + str(i) + ":", linha)
        cursor.close()

if __name__ == '__main__':
    client = mqtt.Client()
    client.on_connect = on_connect
    client.on_message = on_message
    client.connect("test.mosquitto.org", 1883, 60)
    client.subscribe("ControllerRGB")
    
    # a função abaixo manipula trafego de rede, trata callbacks e manipula reconexões.
    client.loop_forever()

    if con.is_connected():
        con.close()

