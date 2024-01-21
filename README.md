# event_channel_example
## 플러터 iOS Event Channel Exmaple
channel 이름을 정한후, 각각 지정.  
flutter 에선 .receiveBroadcastStream().map을 사용해서 Stream으로 int 값을 받아옴.  

swift 에선 onListen을 사용해서 event을 지속적으로 내보내준다. 대신 onCancel이 꼭 필요하다.  
