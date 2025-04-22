# Lyrics Wizard

A simple plugin to help manipulate lyrics in specific verses in MuseScore Studio.

## Installation

Click the green "&lt;&gt; Code" button and click "Download Zip", unzip it, and
move the "lyrics-wizard" folder inside your Plugins folder.  This is normally
in your Documents folder under MuseScore3 or MuseScore4.

Then, in MuseScore Studio, choose "Manage Plugins…" or "Plugin Manager…" from the
Plugins manager.  In MuseScore 3, check the box next to the "lyrics-wizard" plugin
and click "OK". In MuseScore 4, select the "Lyrics Wizard" plugin and click the
"Enable" button in the bottom right corner, then click the "Score" tab in the top
left corner.

There should now be a menu item called "Lyrics Wizard" under the Plugins menu.
In MuseScore 4, this will be under a submenu called "Composing/arranging tools".
You must have a score open to use this plugin.

## Usage

Start by selecting some lyrics.  You can either select a range of measures that
contain notes with lyrics, or select just the lyrics themselves.  Then, choose
"Lyrics Wizard" from the Plugins menu.

A window will appear with a list of checkboxes for each verse, and a preview
of what the lyrics are for each verse within your selection.  Start by checking
the boxes for the verses you want to manipulate, or click the Select All button
to select all verses.  (If all verses are already selected, clicking the Select
All button will deselect them.)

To select only the specified verses of lyrics, click the "Select & Close" button.
This will close the Lyrics Wizard window, leaving only the specified verses
selected within your selected range.

To move the specified lyrics to a different verse, click the "Move Up" or
"Move Down" buttons.  This should work perfectly if the verse you're moving to
doesn't exist, or is empty (for example, if you want to insert a verse by moving
the two verses down).  If you're swapping two existing verses (for example, if
you want to swap verses 1 and 2 either by moving verse 2 up, or by moving verse 1
down), it will move each syllable individually, and if some of the selected notes
don't have any lyric in the verse you're moving to, things can get scrambled.
Use caution, especially if you need to move your verse more than once. Proofreading
the results after each move is highly recommended.

When you've finished, simply close the window.  You must use the mouse to click
the Close button; if you try to close the window with a keyboard shortcut, it
will close your score instead.

## Examples

### Deleting extra verses

Let's say you have a song with a verse section and a chorus section which repeat,
and the verse section has two different verses.  You realize that instead of a
simple repeat, you want to change something so the two verses aren't the same,
and the best way to do this is to insert the second verse after the chorus, and
replace the repeat with a D.S. al Coda.  You start by inserting some blank measures
after the chorus, then copying and pasting the verse and fixing the repeats.
However, now both verses have both sets of lyrics.  You need to delete the verse
2 lyrics from where verse 1 is, and delete the verse 1 lyrics from where verse 2
is.  That's where this plugin comes in!

First, select the beginning of verse 1 and shift-click the ending of verse 1 (you
can select either the measures or just the lyrics; either way it will select both
verses).  Choose "Lyrics Wizard" from the Plugins menu, and check the box next to
Verse 2.  Click the "Select & Close" button, and now only the verse 2 lyrics
will be selected.  Simply press the Delete key to get rid of them.

Next, select the beginning of verse 2 and shift-click the ending of verse 2.
Choose "Lyrics Wizard" from the Plugins menu again, and this time check the box
next to Verse 1.  Click "Select & Close" and press Delete.  Only the verse 2
lyrics will remain, but you want to move these up by changing the verse number
from 2 to 1.  Select these lyrics, then you can either change the verse number
in the sidebar, or use the Lyrics Wizard plugin again and click the "Move Up"
button - whichever way you find more convenient.

### Inserting new verses

Let's say your song already has three verses, but you want to insert a new one
as verse 2, moving the old verses 2 and 3 to 3 and 4.  Start by selecting
the beginning of the verses and shift-clicking on the end of the verses to
select the range (you can select either the measures or just the lyrics; either
way it will select both verses).  Choose "Lyrics Wizard" from the Plugins menu,
and check the boxes for verses 2 and 3.  Click the "Move Down" button to move
these to verses 3 and 4, leaving verse 2 blank.  Close the Lyrics Wizard window
and enter your verse 2 lyrics.

## Version compatibility

This plugin is intended to work with both MuseScore 3.x and MuseScore 4.x on
Windows, Mac and Linux, but have only been tested in 3.6.2, 4.0 and 4.5 on Mac.
As with most plugins, it is very likely to break in a future version
of MuseScore, and will need to be rewritten.
