import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.0
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.2
import QtQuick.Dialogs 1.2
import QtQuick.Controls.Styles 1.3
import "./QML/resources"


ApplicationWindow {

    property  int index
    id:mainWindow
    visible: true
    width:  860
    height: 640
    title: qsTr("图片浏览器")
    Action {
    id: openAction
    text: "&Open"
    shortcut: "Ctrl+O"
    onTriggered: fileDialog.open()
    tooltip: "Open an Image"
    }
       menuBar: MenuBar {
        Menu {
            title: "<b>File</b>"
            MenuItem {  text: "<b><h2>Open...</h2></b>"
                        action: openAction }
            MenuItem {  text: "<b>Close</b>" }
        }
    }



    BusyIndicator{   //忙等的样式
        id:busyIndicator;
        running:false;
        anchors.centerIn: parent;
        z:2;
    }
    Text{
        id:stateText
        visible: false
        anchors.centerIn: parent;
        z:3;
    }


    //文件对话框
     FileDialog {
         id: fileDialog;
         title: "Please choose a file";
         nameFilters: ["Image Files (*.jpg *.png *.gif)",
                       "Bitmap Files (*.bmp)", "* (*.*)"];
         selectMultiple: true;
         onAccepted: {
             img.source = fileDialog.fileUrls[1];
             img1.source = fileDialog.fileUrls[0];
             img2.source = fileDialog.fileUrls[2];
             var imageFile = new String(fileDialog.fileUrls[0]);
           //  console.log("fileUrls num = "+fileDialog.fileUrls.length);
             imagePath.text = imageFile.slice(8);
         }
      }

     NextPage{     //下一张
         id:nextPicture;
         width:100;
         height: 50;
         anchors.right: parent.right;
         anchors.bottom:parent.bottom;
     }

     PreviousPage{     //上一张
         id:previousPicture
         width:100
         height: 50
         anchors.left: parent.left
         anchors.bottom:parent.bottom
     }

     Label{
        id:currentPage;
        width: 50
        height:30
        anchors.left: previousPicture.right
        anchors.bottom: parent.bottom
        anchors.leftMargin: 120
        font.pixelSize: 22
        text: "<b>第</b> "+mainWindow.index +" <b>页</b>"
     }

     Label{
        id:sumPages;
        width:50;
        height:30;
        anchors.right: nextPicture.left;
        anchors.bottom: parent.bottom
        anchors.rightMargin: 150
        font.pixelSize: 22
        text:"<b>总页数</b> "+fileDialog.fileUrls.length;
     }

     Rectangle{
         id:imageDisplay;
         width:500;
         height:500;
         anchors.left: parent.left;
         anchors.leftMargin:100
         anchors.top:parent.top
         anchors.topMargin: 30
         ImageDisplay{
               id:img;
               width:parent.width;
               height:parent.height;
               anchors.centerIn: parent;
               fillMode: Image.PreserveAspectFit;
         }
     }

     Rectangle{
                id:previewImgBox
                width:100
                height: 400
                anchors.right:parent.right
             Rectangle{
                 id:img1Box
                 width: 100
                 height:100
                 anchors.right: parent.right
                 border.width: 2
                 border.color:"blue"
                 Image{
                     id:img1;
                     width:100
                     height:100
                     asynchronous: true; //开启异步加载
                     cache:false;
                     anchors.centerIn: parent;
                     fillMode: Image.PreserveAspectFit;  //图片按比例缩放
                     onStatusChanged: {
                         if(img.status == Image.Loading){
                            busyIndicator.running = true;
                            stateText.visible = false;
                         }
                         else if(img.status == Image.Ready){
                               busyIndicator.running = false;
                         }
                         else if(img.status == Image.Error){
                             busyIndicator.running = false;
                               stateText.visible = true;
                               stateText.text = "ERROR";
                         }
                     }
                 }
             }
             Rectangle
             {
                 id:img2Box
                 width: 100
                 height:100
                 anchors.top:img1Box.bottom
                 anchors.topMargin: 20
                 anchors.centerIn: parent
                 border.width: 2
                 border.color:"blue"

                 Image{
                     id:img2;
                     width:100
                     height:100
                     asynchronous: true; //开启异步加载
                     cache:false;
                     anchors.centerIn: parent;
                     fillMode: Image.PreserveAspectFit;  //图片按比例缩放
                     onStatusChanged: {
                         if(img.status == Image.Loading){
                            busyIndicator.running = true;
                            stateText.visible = false;
                         }
                         else if(img.status == Image.Ready){
                               busyIndicator.running = false;
                         }
                         else if(img.status == Image.Error){
                             busyIndicator.running = false;
                               stateText.visible = true;
                               stateText.text = "ERROR";
                         }
                     }
                 }
             }
       }
}
