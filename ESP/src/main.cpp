#include <WiFi.h>
#include <PubSubClient.h>
#include <Adafruit_NeoPixel.h>

#define PIN_CONNECTION 2
#define PIN_RELE 26
#define PIN_SLIDER 16

#define PIN_LED_RGB 25
#define NUMLED 9

#define TOPICO_SUBSCRIBE "teste251120"
#define TOPICO_PUBLISH "teste251120"
#define ID_MQTT  "esp32_mqtt"    
 
const char* SSID = "Pixar"; // SSID / nome da rede WI-FI
const char* PASSWORD = "51993313"; // Senha da rede WI-FI
 
const char* BROKER_MQTT = "test.mosquitto.org";
int BROKER_PORT = 1883;
   
/*================================================================================*/
WiFiClient espClient;
PubSubClient MQTT(espClient);
Adafruit_NeoPixel pixels(NUMLED, PIN_LED_RGB, NEO_GRB + NEO_KHZ800);
int rgbColor[3] ={255,255,255};
bool rgbState = false;
bool normalState = false;
double sliderState = 0.0;
/*================================================================================*/
void setStripColor(String data);
void setStripState(String data);
void setLightState(String data);
void setSliderState(String data);
void initWiFi(void);
void initMQTT(void);
void mqtt_callback(char* topic, byte* payload, unsigned int length);
void reconnectMQTT(void);
void reconnectWiFi(void);
void VerificaConexoesWiFIEMQTT(void);
/*================================================================================*/
void setStripColor(String data){
    
    int posVirgula = data.indexOf(',');
    int red = data.substring(0, posVirgula).toInt();
    data = data.substring(posVirgula+1);

    posVirgula = data.indexOf(',');
    int green = data.substring(0, posVirgula).toInt();
    data = data.substring(posVirgula+1);

    int blue = data.toInt();

    /*
    Serial.println(red);
    Serial.println(green);
    Serial.println(blue);
    */

    rgbColor[0] = red;
    rgbColor[1] = green;
    rgbColor[2] = blue;

    if(rgbState){
        pixels.fill(pixels.Color(red,green,blue),0, NUMLED);
        pixels.show();
    }
}
void setStripState(String data){
    rgbState = data.equals("1");
    
    if(rgbState)
        pixels.fill(pixels.Color(rgbColor[0],rgbColor[1],rgbColor[2]),0, NUMLED);
    else
        pixels.fill(pixels.Color(0,0,0),0, NUMLED);
    
    pixels.show();
};
void setLightState(String data){
    normalState = data.equals("1");
    digitalWrite(PIN_RELE, normalState ? HIGH : LOW);
};
void setSliderState(String data){
    sliderState = data.toDouble();
    ledcWrite(0, sliderState);
};
//Inicializa e conecta-se na rede WI-FI desejada
void initWiFi(void) {
    delay(10);
    Serial.println("------Conexao WI-FI------");
    Serial.print("Conectando-se na rede: ");
    Serial.println(SSID);
    Serial.println("Aguarde");
      
    reconnectWiFi();
}
// Inicializa parâmetros de conexão MQTT(endereço do broker, porta e seta função de callback)
void initMQTT(void) {
    MQTT.setServer(BROKER_MQTT, BROKER_PORT);   //informa qual broker e porta deve ser conectado
    MQTT.setCallback(mqtt_callback);            //atribui função de callback
}
//Função de callback esta função é chamada toda vez que uma informação de um dos tópicos subescritos chega)
void mqtt_callback(char* topic, byte* payload, unsigned int length) {
    String msg;
  
    /* obtem a string do payload recebido */
    for(int i = 0; i < length; i++) 
    {
       char c = (char)payload[i];
       msg += c;
    }
    int separador = msg.indexOf('|');

    String identificador = msg.substring(0, separador);
    String data = msg.substring(separador+1, msg.length());

    if(identificador.equals("1")){
        if(data.length()>1){
            setStripColor(data);
            Serial.print("RGB Color: ");
        }else{
            setStripState(data);
            Serial.print("RGB State: ");
        }
        Serial.println(data);
    }else if(identificador.equals("2")){
        setLightState(data);
        Serial.print("Normal: ");
        Serial.println(data);
    }else if(identificador.equals("3")){
        setSliderState(data);
        Serial.print("Slider: ");
        Serial.println(data);
    }else if(msg.equals("DataRequest")){
        //char rgbColorData[14] = {0};
        char rgbStateData[4]= {0};
        char normalStateData[4]= {0};
        /*
        sprintf(rgbColorData, "1|%d,%d,%d", rgbColor[0], rgbColor[1], rgbColor[2]);
        Serial.println(rgbColorData);
        MQTT.publish(TOPICO_PUBLISH, rgbColorData);
        */
        sprintf(rgbStateData, "1|%d", rgbState);
        Serial.println(rgbStateData);
        MQTT.publish(TOPICO_PUBLISH, rgbStateData);

        sprintf(normalStateData, "2|%d", normalState);  
        delay(5);
        Serial.println(normalStateData);
        MQTT.publish(TOPICO_PUBLISH, normalStateData);
        
    }
}
//Função: Reconecta-se ao broker MQTT em caso de sucesso na conexão ou reconexão, o subscribe dos tópicos é refeito.
void reconnectMQTT(void) {
    while (!MQTT.connected()) 
    {
        Serial.print("* Tentando se conectar ao Broker MQTT: ");
        Serial.println(BROKER_MQTT);
        if (MQTT.connect(ID_MQTT)) 
        {
            Serial.println("Conectado com sucesso ao broker MQTT!");
            digitalWrite(PIN_CONNECTION,HIGH);
            MQTT.subscribe(TOPICO_SUBSCRIBE); 
        } 
        else
        {
            digitalWrite(PIN_CONNECTION,LOW);
            Serial.println("Falha ao reconectar no broker.");
            Serial.println("Havera nova tentatica de conexao em 2s");
            delay(2000);
        }
    }
}
//Verifica o estado das conexões WiFI e ao broker MQTT. Em caso de desconexão, a conexão é refeita.
void VerificaConexoesWiFIEMQTT(void){
    if (!MQTT.connected()) 
        reconnectMQTT(); //se não há conexão com o Broker, a conexão é refeita
      
     reconnectWiFi(); //se não há conexão com o WiFI, a conexão é refeita
}
//Reconecta-se ao WiFi
void reconnectWiFi(void) {
    //se já está conectado a rede WI-FI, nada é feito. 
    //Caso contrário, são efetuadas tentativas de conexão
    if (WiFi.status() == WL_CONNECTED)
        return;
          
    WiFi.begin(SSID, PASSWORD); // Conecta na rede WI-FI
      
    while (WiFi.status() != WL_CONNECTED) 
    {
        delay(100);
        Serial.print(".");
    }
    
    Serial.println();
    Serial.print("Conectado com sucesso na rede ");
    Serial.print(SSID);
    Serial.println("IP obtido: ");
    Serial.println(WiFi.localIP());
}
/*============================================================*/
void setup() {
    Serial.begin(115200);
    pixels.begin();

    pinMode(PIN_CONNECTION, OUTPUT);
    digitalWrite(PIN_CONNECTION,LOW);

    pinMode(PIN_SLIDER, OUTPUT);//Definimos o pino 2 (LED) como saída.
    ledcAttachPin(PIN_SLIDER, 0);//Atribuimos o pino 2 ao canal 0.
    ledcSetup(0, 1000, 10);

    pinMode(PIN_RELE, OUTPUT);
    digitalWrite(PIN_RELE,LOW);

    initWiFi();
    initMQTT();

}
/*============================================================*/
void loop() 
{
    VerificaConexoesWiFIEMQTT();
    MQTT.loop();
}