/*
 * SPDX-License-Identifier: GPL-3.0-only
 * MuseScore-Studio-CLA-applies
 *
 * Lyrics Wizard
 * Copyright (C) 2025 Andy Lyttle
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License version 3 as
 * published by the Free Software Foundation.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <https://www.gnu.org/licenses/>.
 */

import QtQuick 2.2
import MuseScore 3.0
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import "DialogBox.js" as DialogBox

MuseScore {
      id: msParent
      version:  "1.0"
      description: "Easily select and move lyrics around between verses."
      menuPath: "Plugins.Lyrics Wizard" // Ignored in MuseScore 4

      // These special comments are parsed by MuseScore 4.4, but ignored by older versions:
      //4.4 title: "Lyrics Wizard"
      //4.4 thumbnailName: "lyrics-wizard.png"
      //4.4 categoryCode: "composing-arranging-tools"
      
      // The same thing for MuseScore 4.0-4.3, ignored by 4.4:
      Component.onCompleted: {
            if (mscoreMajorVersion == 4 && mscoreMinorVersion <= 3) {
                  title = "Lyrics Wizard";
                  thumbnailName = "lyrics-wizard.png";
                  categoryCode = "composing-arranging-tools";
            }
      }

      ApplicationWindow {
            id: lyricsWizardWindow
            title: "Lyrics Wizard"
            width: 530
            height: 400
            visible: false
            
            Label {
                  anchors {
                        top: parent.top
                        left: parent.left
                        right: parent.right
                        margins: 20
                  }
                  text: "Check the boxes to select the verses you want."
            }

            ScrollView {
                  id: scrollView
                  ScrollBar.horizontal.policy: ScrollBar.AlwaysOff
                  ScrollBar.vertical.policy: ScrollBar.AsNeeded
                  clip: true
                  anchors {
                        top: parent.top
                        bottom: parent.bottom
                        left: parent.left
                        right: parent.right
                        topMargin: 50
                        bottomMargin: 110
                        fill: parent
                  }
                  Item {
                        id: verseList
                        width: parent.width
                  }
                  //background: Rectangle {color: 'red'}
            }
            
            Label {
                  anchors {
                        bottom: parent.bottom
                        bottomMargin: 70
                        horizontalCenter: parent.horizontalCenter
                  }
                  horizontalAlignment: Text.AlignHCenter
                  text: "Use caution when swapping the order of verses.\nEach syllable is moved individually, so blanks can scramble things."
            }
            RowLayout {
                  height: 80
                  spacing: 10
                  anchors {
                        horizontalCenter: parent.horizontalCenter
                        bottom: parent.bottom
                  }
                  Button {
                        text: "Check All"
                        onClicked: clickCheckAll()
                  }
                  Button {
                        id: btnSelect
                        text: "Select && Close"
                        onClicked: clickSelect()
                  }
                  Button {
                        text: "Move Up"
                        onClicked: clickMoveUp()
                  }
                  Button {
                        text: "Move Down"
                        onClicked: clickMoveDown()
                  }
            }
            onClosing: function() {
                  (typeof(quit) === 'undefined' ? Qt.quit : quit)();
            }
      }
      
      property var selectBoxes: []
      property var lyricPreviews: []
      property var verses: []
      
      function addVerse(v, txt) {
            var pos = v * 40;
            verseList.height += 40
            verseList.implicitHeight += 40
            var offset = pos;
            if(mscoreMajorVersion < 4) offset = pos - 6;
            
            var qmlText = "";
            qmlText += "import QtQuick 2.2\n";
            qmlText += "import MuseScore 3.0\n";
            qmlText += "import QtQuick.Controls 2.2\n";
            qmlText += "CheckBox {\n";
            qmlText += 'text: "Verse ' + (v+1) + '"' + "\n";
            qmlText += "anchors { top: parent.top; left: parent.left; topMargin: " + offset + "; leftMargin: 10 }\n";
            qmlText += "}\n";
            selectBoxes[v] = Qt.createQmlObject(qmlText, verseList, "addVerse()");
            
            qmlText = "";
            qmlText += "import QtQuick 2.2\n";
            qmlText += "import MuseScore 3.0\n";
            qmlText += "import QtQuick.Controls 2.2\n";
            qmlText += "TextArea {\n";
            //qmlText += "width: 400\n";
            qmlText += "height: 30\n";
            //qmlText += "background: Rectangle {color: 'blue'}\n";
            qmlText += "font.pointSize: 16\n";
            qmlText += "font.family: 'Edwin'\n";
            qmlText += "readOnly: true\n";
            qmlText += "anchors { top: parent.top; left: parent.left; topMargin: " + pos + "; leftMargin: 120; }\n";
            qmlText += "}\n";
            lyricPreviews[v] = Qt.createQmlObject(qmlText, verseList, "addVerse()");
            lyricPreviews[v].text = txt;
      }
      
      function clickCheckAll() {
            // Check all Verse checkboxes in the UI, or clear them all if they're all already checked
            var allChecked = true;
            for(var v=0; v<selectBoxes.length; v++) {
                  if(!selectBoxes[v].checked) allChecked = false;
            }
            for(var v=0; v<selectBoxes.length; v++) {
                  selectBoxes[v].checked = !allChecked;
            }
      }
      function clickSelect() {
            // Select all lyric words within the original selection, for verses that are checked
            curScore.startCmd();
            curScore.selection.clear();
            for(var v=0; v<selectBoxes.length; v++) {
                  if(!selectBoxes[v].checked || !verses[v]) continue;
                  for(var i=0; i<verses[v].length; i++) {
                        var e = verses[v][i];
                        curScore.selection.select(e, true);
                  }
            }
            curScore.endCmd();
            lyricsWizardWindow.close();
      }
      function clickMoveUp() {
            curScore.startCmd();
            for(var v=0; v<selectBoxes.length; v++) {
                  if(!selectBoxes[v].checked || !verses[v]) continue;
                  for(var i=0; i<verses[v].length; i++) {
                          var e = verses[v][i];
                          e.verse -= 1;
                  }
            }
            curScore.endCmd();
            reloadLyrics();
      }
      function clickMoveDown() {
            curScore.startCmd();
            for(var v=selectBoxes.length-1; v>-1; v--) {
                  if(!selectBoxes[v].checked || !verses[v]) continue;
                  for(var i=0; i<verses[v].length; i++) {
                          var e = verses[v][i];
                          e.verse += 1;
                  }
            }
            curScore.endCmd();
            reloadLyrics();
      }
      function reloadLyrics() {
            for(var v=0; v<selectBoxes.length; v++) {
                  selectBoxes[v].destroy();
            }
            selectBoxes = [];

            for(var v=0; v<lyricPreviews.length; v++) {
                  lyricPreviews[v].destroy();
            }
            lyricPreviews = [];
            
            getSelectedLyrics();
            if(!verses) {
                  // If the user has changed the selection so that now nothing is selected, give up and close the window
                  lyricsWizardWindow.close();
            }
      }
      function getSelectedLyrics() {
            verses = [];
            for(var i in curScore.selection.elements) {
                  var e = curScore.selection.elements[i];
                  if(e.type == Element.LYRICS) {
                        if(!verses[e.verse]) verses[e.verse] = [];
                        verses[e.verse].push(e);
                  }
            }
            if(verses.length) {
                  for(var v=0; v<verses.length; v++) {
                        if(verses[v] && verses[v].length) {
                              var textPreview = "";
                              for(var i=0; i<verses[v].length; i++) {
                                    var e = verses[v][i];
                                    if(e.syllabic == Lyrics.BEGIN || e.syllabic == Lyrics.MIDDLE) {
                                          textPreview += e.text + "-";
                                    } else if(e.lyricTicks.numerator) {
                                          // string.repeat() does not exist in MuseScore 3.6
                                          var melisma = "";
                                          for(var j=0; j<e.lyricTicks.numerator; j++) {
                                                melisma += "_";
                                          }
                                          textPreview += e.text + melisma + " ";
                                    } else {
                                          textPreview += e.text + " ";
                                    }
                              }
                              addVerse(v, textPreview);
                        } else {
                              addVerse(v, "(empty selection)");
                        }
                  }
            }
      }

      onRun: {
            if(mscoreMajorVersion < 4) btnSelect.text = "Select & Close"; // ampersand doesn't need to be escaped in MS3
            getSelectedLyrics();
            if(verses.length) {
                  lyricsWizardWindow.show();
            } else {
                  DialogBox.showWarning("Please select some lyrics!");
            }
      }
}
