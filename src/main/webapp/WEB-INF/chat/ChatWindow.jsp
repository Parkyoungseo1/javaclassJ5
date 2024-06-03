<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Chat Application</title>
<script>
//var webSocket = new WebSocket("ws://172.20.10.5:9090/javaclassJ5/websocket"); // 노트북용
var webSocket = new WebSocket("ws://192.168.50.68:9090/javaclassJ5/websocket"); // 학원 내컴퓨터용
//var webSocket = new WebSocket("ws://192.168.50.20:9090/javaclassJ5/websocket"); // 쌤 컴퓨터용

var chatWindow, chatMessage, chatId;

// 채팅창이 열리면 대화창, 메시지 입력창, 아이디 표시란으로 사용할 DOM 객체 저장
// 윈도우가 로드되면 실행할 익명 함수
window.onload = function() {
    chatWindow = document.getElementById("chatWindow");
    chatMessage = document.getElementById("chatMessage");
    chatId = document.getElementById("chatId").value;
};

// 메시지 전송
function sendMessage() {
    // 대화창에 표시 
    chatWindow.innerHTML += "<div class='myMsg'>" + chatMessage.value + "</div>";
    webSocket.send(chatId + '|' + chatMessage.value); // 서버로 전송
    chatMessage.value = ""; //메시지 입력창 내용 지우기
    chatWindow.scrollTop = chatWindow.scrollHeight; // 대화창 스크롤
}

function disconnect() { // 함수명 수정
    webSocket.close();
}

// 엔터 키 입력 처리
function enterKey() {
    if (window.event.keyCode == 13) { // 13 = Enter 키의 코드값
        sendMessage();
    }
}

// 웹소켓 서버에 연결되었을 때 실행
webSocket.onopen = function(event) {
    chatWindow.innerHTML += "<div class='systemMsg'>웹소켓 서버에 연결되었습니다.</div>";
};

// 웹소켓이 닫혔을 때 실행
webSocket.onclose = function(event) {
    chatWindow.innerHTML += "<div class='systemMsg'>웹소켓 서버가 종료되었습니다.</div>";
}

webSocket.onerror = function(event) {
    alert(event.data);
    chatWindow.innerHTML += "<div class='systemMsg'>채팅 중 에러가 발생하였습니다.</div>";
}

// 메시지를 받았을 때 실행
webSocket.onmessage = function(event) {
    var message = event.data.split("|"); // 대화명과 메시지 분리
    var sender = message[0];
    var content = message[1];
    if (content != "") {
        if (content.match("/")) { // 귓속말
            if (content.match(("/" + chatId))) { // 나에게 보낸 메시지만 출력
                var temp = content.replace(("/" + chatId), "[귓속말]: ");
                chatWindow.innerHTML += "<div class='whisperMsg'>" + sender + "" + temp + "</div>";
            }
        } else { // 일반 대화
            chatWindow.innerHTML += "<div class='otherMsg'>" + sender + ": " + content + "</div>";
        }
    }
    chatWindow.scrollTop = chatWindow.scrollHeight;
};
</script>
<style>
body {
    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    background-color: #f2f2f2;
    margin: 0;
    padding: 0;
    display: flex;
    justify-content: center;
    align-items: center;
    height: 100vh;
}

.chatContainer {
    width: 40%;
    max-width: 600px;
    min-width: 300px;
    background: #fff;
    padding: 20px;
    box-shadow: 0 0 20px rgba(0, 0, 0, 0.1);
    border-radius: 10px;
    display: flex;
    flex-direction: column;
}

#chatWindow {
    border: 1px solid #ccc;
    height: 300px;
    overflow-y: scroll;
    padding: 15px;
    background: #fafafa;
    border-radius: 10px;
    margin-bottom: 15px;
}

#chatMessage {
    width: calc(100% - 70px);
    height: 40px;
    padding: 10px;
    border: 1px solid #ccc;
    border-radius: 5px;
    font-size: 16px;
}

#sendBtn, #closeBtn {
    height: 40px;
    width: 60px;
    border: none;
    background-color: #007BFF;
    color: white;
    border-radius: 5px;
    cursor: pointer;
    font-size: 16px;
    margin-left: 10px;
}

#sendBtn:hover, #closeBtn:hover {
    background-color: #0056b3;
}

#chatId {
    width: calc(100% - 80px);
    height: 40px;
    padding: 10px;
    border: 1px solid #ccc;
    background-color: #f9f9f9;
    border-radius: 5px;
    font-size: 16px;
    margin-bottom: 15px;
}

.myMsg {
    text-align: right;
    color: #007BFF;
    margin: 5px 0;
    word-wrap: break-word;
}

.otherMsg {
    text-align: left;
    color: #333;
    margin: 5px 0;
    word-wrap: break-word;
}

.whisperMsg {
    text-align: left;
    color: #d9534f;
    margin: 5px 0;
    word-wrap: break-word;
}

.systemMsg {
    text-align: center;
    color: #999;
    margin: 5px 0;
    font-style: italic;
}
</style>
</head>
<body>
<div class="chatContainer">
    <div>
        <label for="chatId">아이디:</label>
        <input type="text" id="chatId" value="${ param.chatId }" readonly />
        <button id="closeBtn" onclick="disconnect();">종료</button>
    </div>
    <div id="chatWindow"></div>
    <div style="display: flex; align-items: center;">
        <input type="text" id="chatMessage" onkeyup="enterKey();" placeholder="메시지를 입력하세요...">
        <button id="sendBtn" onclick="sendMessage();">전송</button>
    </div>
</div>
</body>
</html>