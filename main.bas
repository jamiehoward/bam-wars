DECLARE SUB allocate (pp%, pnt1%, pnt2%, pwrname1$, pwrname2$)
DECLARE SUB level (lvl%, hp%, vic%, pp%)
DECLARE FUNCTION load! ()
DECLARE FUNCTION rps$ (hand1$, hand2$, outcome%)
DECLARE SUB SetEnemyStats (lvl%, ehp%, elvl%, epnt1%, epnt2%)
DECLARE SUB startmenu ()
DECLARE SUB fight (name$, pwrname1$, pwr1$, pwrname2$, pwr2$, hp%, lvl%, pp%, vic%, pnt1%, pnt2%)
DECLARE SUB MainMenu (name$, pwrname1$, pwr1$, pwrname2$, pwr2$, hp%, lvl%, pp%, vic%, pnt1%, pnt2%)
DECLARE FUNCTION GetEnemyName$ (en%, ename$, epwrname1$, epwrname2$, epwr1$, epwr2$)
DECLARE SUB introduction ()
'***********BAM-WARS************
'        2.13.07 BAM #106
'INTRODUCTION
SCREEN 2
introduction
startmenu
1 CLS
LOCATE 4, 20: PRINT "--------BAM WARS--------"
LOCATE 5, 20: PRINT "  Choose a character name  "
LOCATE 6, 16: PRINT "(No spaces, or saving won't work)"
LOCATE 7, 30: INPUT "", name$
IF name$ = "" THEN GOTO 1
SLEEP 1

'Building first power
2 CLS
LOCATE 4, 20: PRINT "Enter name for first power."
LOCATE 5, 30: INPUT "", pwrname1$
IF pwrname1$ = "" THEN GOTO 2
3 LOCATE 7, 18: PRINT "Will this be an attack or defense?"
LOCATE 8, 30: INPUT "", pwrtype1$
        pwrtype1$ = UCASE$(pwrtype1$)
        IF pwrtype1$ = "ATTACK" THEN GOTO 5
        IF pwrtype1$ <> "DEFENSE" THEN GOTO 3
        IF pwrtype1$ = "DEFENSE" THEN GOTO 4
4 LOCATE 9, 10: PRINT "Will this defense be healing or dmg reduction?"
LOCATE 10, 30: INPUT "", defpwr1$
        defpwr1$ = UCASE$(defpwr1$)
        IF defpwr1$ = "HEAL" THEN pwr1$ = "Heal"
        IF defpwr1$ = "HEALING" THEN pwr1$ = "Heal"
        IF defpwr1$ <> "DMG REDUCTION" THEN GOTO 4
        IF defpwr1$ = "DMG REDUCTION" THEN pwr1$ = "DmgRed"

GOTO 6
5 pwr1$ = "Attack"
GOTO 6

'Building second power
6 CLS
LOCATE 4, 20: PRINT "Enter name for second power."
LOCATE 5, 30: INPUT "", pwrname2$

7 LOCATE 7, 18: PRINT "Will this be an attack or defense?"
LOCATE 8, 30: INPUT "", pwrtype2$
        pwrtype2$ = LCASE$(pwrtype2$)
        IF pwrtype2$ = "attack" THEN GOTO 9
        IF pwrtype2$ <> "defense" THEN GOTO 7
        IF pwrtype2$ = "defense" THEN GOTO 8

8 LOCATE 9, 10: PRINT "Will this defense be healing or dmg reduction?"
LOCATE 10, 30: INPUT "", defpwr2$
        defpwr2$ = LCASE$(defpwr2$)
        IF defpwr2$ = "healing" THEN pwr2$ = "Heal"
        IF defpwr2$ <> "dmg reduction" THEN GOTO 8
        IF defpwr2$ = "dmg reduction" THEN pwr2$ = "DmgRed"

GOTO 10
9 pwr2$ = "Attack"
GOTO 10

10 CLS
LOCATE 4, 20: PRINT "Name: "; name$
LOCATE 5, 20: PRINT "Power 1: "; pwrname1$; " ("; pwr1$; ")"
LOCATE 6, 20: PRINT "Power 2: "; pwrname2$; " ("; pwr2$; ")"
LOCATE 8, 20: PRINT "You have 10 points to spend"
LOCATE 9, 20: PRINT "    on your powers."
LOCATE 10, 20: PRINT "How many points toward "; pwrname1$; "?"
LOCATE 11, 30: INPUT "", pnt1%
pnt2:
LOCATE 12, 20: PRINT "How many points toward "; pwrname2$; "?"
LOCATE 13, 30: INPUT "", pnt2%
        IF pnt1% = 0 THEN GOTO 10
        IF pnt2% = 0 THEN GOTO pnt2
        IF pnt1% + pnt2% > 10 THEN GOTO 10
        IF pnt1% + pnt2% < 10 THEN GOTO 10
SLEEP 1
        hp% = 10
        vic% = 0
        pp% = 0
        lvl% = 1

'Character building completed!
11 CLS
LOCATE 4, 20: PRINT "Character building completed!"
CALL MainMenu(name$, pwrname1$, pwr1$, pwrname2$, pwr2$, hp%, lvl%, pp%, vic%, pnt1%, pnt2%)

SUB allocate (pp%, pnt1%, pnt2%, pwrname1$, pwrname2$)
CLS
IF pp% = 1 THEN l$ = ""
IF pp% > 1 THEN l$ = "s"
LOCATE 4, 20: PRINT pwrname1$; " ["; pnt1%; "]"
LOCATE 5, 20: PRINT pwrname2$; " ["; pnt2%; "]"
LOCATE 7, 20: PRINT "You have "; pp%; " point"; l$; "."
SLEEP 1
Allocate1:
        IF pp% < 1 THEN GOTO endAllocate
        LOCATE 8, 20: PRINT "How many on "; pwrname1$; "?"
        LOCATE 9, 38: PRINT "]"
        LOCATE 9, 35: INPUT "[", allo1%
        IF allo1% > pp% THEN GOTO Allocate1
        pnt1% = pnt1% + allo1%
        pp% = pp% - allo1%
        IF pp% = 1 THEN l$ = ""
        IF pp% > 1 THEN l$ = "s"
        LOCATE 4, 20: PRINT pwrname1$; " ["; pnt1%; "]"
        LOCATE 7, 20: PRINT "You have "; pp%; " point"; l$

Allocate2:
        LOCATE 11, 20: PRINT "How many on "; pwrname2$; "?"
        LOCATE 12, 38: PRINT "]"
        LOCATE 12, 35: INPUT "[", allo2%
        IF allo2% > pp% THEN GOTO Allocate2
        pnt2% = pnt2% + allo2%
        pp% = pp% - allo2%
        IF pp% = 1 THEN l$ = ""
        IF pp% > 1 THEN l$ = "s"
        LOCATE 5, 20: PRINT pwrname2$; " ["; pnt2%; "]"
        LOCATE 7, 20: PRINT "You have "; pp%; " point"; l$
        SLEEP 2
IF pp% > 0 THEN GOTO Allocate1
endAllocate:
END SUB

SUB fight (name$, pwrname1$, pwr1$, pwrname2$, pwr2$, hp%, lvl%, pp%, vic%, pnt1%, pnt2%)
CLS
enemyname% = 0
enemyname$ = ""
50 LOCATE 4, 25: PRINT "Begin fight with "; GetEnemyName$(en%, ename$, epwrname1$, epwrname2$, epwr1$, epwr2$); "!"
SLEEP 2
49 CLS
' Character stats
LOCATE 3, 10: PRINT "Level: "; lvl%
LOCATE 4, 10: PRINT name$
LOCATE 5, 10: PRINT "HP: "; hp%
LOCATE 6, 10: PRINT "["; pnt1%; "] "; pwrname1$; " ["; pwr1$; "]"
LOCATE 7, 10: PRINT "["; pnt2%; "] "; pwrname2$; " ["; pwr2$; "]"

51 CALL SetEnemyStats(lvl%, ehp%, elvl%, epnt1%, epnt2%)
IF elvl% = 0 THEN GOTO 51
IF ehp% = 0 THEN GOTO 51
' Enemy Stats
LOCATE 3, 50: PRINT "Level: "; elvl%
LOCATE 4, 50: PRINT ename$
LOCATE 5, 50: PRINT "HP: "; ehp%
LOCATE 6, 50: PRINT "["; epnt1%; "] "; epwrname1$; " ["; epwr1$; "]"
LOCATE 7, 50: PRINT "["; epnt2%; "] "; epwrname2$; " ["; epwr2$; "]"

52 LOCATE 10, 30: PRINT "Attack or Run?"
LOCATE 11, 32: INPUT "", fdecision$
        fdecision$ = UCASE$(fdecision$)
        IF fdecision$ = "ATTACK" THEN GOTO 54
        IF fdecision$ <> "RUN" THEN GOTO 52
        IF fdecision$ = "RUN" THEN GOTO 53

53 CALL MainMenu(name$, pwrname1$, pwr1$, pwrname2$, pwr2$, hp%, lvl%, pp%, vic%, pnt1%, pnt2%)

'Fight Begins!
54 LOCATE 14, 30: PRINT "Choose a power."
LOCATE 15, 30: INPUT "", power$
        power$ = UCASE$(power$)
        IF power$ = UCASE$(pwrname1$) THEN GOTO 55
        IF power$ <> UCASE$(pwrname2$) THEN GOTO 54
        IF power$ = UCASE$(pwrname2$) THEN GOTO 56

'If player uses power 1
55 LOCATE 16, 30: PRINT "You use "; pwrname1$; "."
SLEEP 1
LOCATE 17, 20: PRINT ""; rps$(hand1$, hand2$, outcome%)
SLEEP 1
LOCATE 17, 50: PRINT ""; hand2$
SLEEP 1
LOCATE 17, 20: PRINT "         "
LOCATE 17, 50: PRINT "         "
        IF outcome% = 1 THEN
                ehp% = ehp% - pnt1%
                LOCATE 5, 50: PRINT "HP: "; ehp%
                PLAY "c20d20e12"
        SLEEP 1
        END IF
        IF ehp% = 0 THEN GOTO 60
        IF outcome% = 2 THEN
                ehp% = ehp%
                LOCATE 5, 50: PRINT "HP: "; ehp%
                LOCATE 19, 25: PRINT "MISS!"
                PLAY "c30d30e30f30g30f30e30d30c10<<c10<<c10>>>>"
        SLEEP 1
        END IF
        IF ehp% < 1 THEN GOTO 60
LOCATE 16, 20: PRINT "                              "
LOCATE 11, 32: PRINT "          "
LOCATE 15, 30: PRINT "                    "
LOCATE 19, 25: PRINT "      "
GOTO 52

'If player uses power 2
56 LOCATE 16, 30: PRINT "You use "; pwrname2$; "."
SLEEP 1
hand1$ = rps$(hand1$, hand2$, outcome%)
LOCATE 17, 20: PRINT ""; hand1$
SLEEP 1
LOCATE 17, 50: PRINT ""; hand2$
SLEEP 1
LOCATE 17, 20: PRINT "         "
LOCATE 17, 50: PRINT "         "
        IF outcome% = 1 THEN
                ehp% = ehp% - pnt2%
                IF ehp% = 0 THEN GOTO 60
                LOCATE 5, 50: PRINT "HP: "; ehp%
                PLAY "c20d20e12"
        SLEEP 1
        END IF
        IF ehp% = 0 THEN GOTO 60
        IF outcome% = 2 THEN
                ehp% = ehp%
                LOCATE 5, 50: PRINT "HP: "; ehp%
                LOCATE 19, 25: PRINT "MISS!"
                PLAY "c30d30e30f30g30f30e30d30c10<<c10<<c10>>>>"
        SLEEP 1
        END IF
        IF ehp% < 1 THEN GOTO 60
LOCATE 16, 20: PRINT "                              "
LOCATE 11, 32: PRINT "          "
LOCATE 15, 30: PRINT "                    "
LOCATE 19, 25: PRINT "      "
GOTO 52
58
59
60 LOCATE 19, 25: PRINT "VICTORY!!!": PLAY "C20d20e20f20g20f20e20d20c20d20e20f20g20a20b20>c20<"
vic% = vic% + 1
CALL level(lvl%, hp%, vic%, pp%)
SLEEP 3
CLS : GOTO 50
61
END SUB

FUNCTION GetEnemyName$ (en%, ename$, epwrname1$, epwrname2$, epwr1$, epwr2$)
RANDOMIZE TIMER
en% = INT(RND * 20) + 1
IF en% = 1 THEN ename$ = "Orange Dart": GOTO 901
IF en% = 2 THEN ename$ = "Maximus Meridius": GOTO 902
IF en% = 3 THEN ename$ = "Blue Dot": GOTO 903
IF en% = 4 THEN ename$ = "Cyttorax": GOTO 904
IF en% = 5 THEN ename$ = "C Weezy": GOTO 905
IF en% = 6 THEN ename$ = "Soul Flame": GOTO 906
IF en% = 7 THEN ename$ = "Magnanimous Marvin": GOTO 907
IF en% = 8 THEN ename$ = "Crator": GOTO 908
IF en% = 9 THEN ename$ = "Paragon Defense Bot": GOTO 909
IF en% = 10 THEN ename$ = "Citizen's Kid": GOTO 910
IF en% = 11 THEN ename$ = "Fox": GOTO 911
IF en% = 12 THEN ename$ = "Goblin": GOTO 912
IF en% = 13 THEN ename$ = "Troll": GOTO 913
IF en% = 14 THEN ename$ = "Orc": GOTO 914
IF en% = 15 THEN ename$ = "Elf": GOTO 915
IF en% = 16 THEN ename$ = "Dwarf": GOTO 916
IF en% = 17 THEN ename$ = "Bandit": GOTO 917
IF en% = 18 THEN ename$ = "Marcus Ragnatha": GOTO 918
IF en% = 19 THEN ename$ = "Wolf": GOTO 919
IF en% = 20 THEN ename$ = "Bear": GOTO 920
901 'ORANGE DART
        ename$ = "Orange Dart"
        epwrname1$ = "Archer's Bow"
        epwr1$ = "Attack"
        epwrname2$ = "Siphon Power"
        epwr2$ = "DmgRed": GOTO 921
902 'MAXIMUS MERIDIUS
        ename$ = "Maximus Meridius"
        epwrname1$ = "Broad Sword"
        epwr1$ = "Attack"
        epwrname2$ = "Shield"
        epwr2$ = "DmgRed": GOTO 921
903 'BLUE DOT
        ename$ = "Blue Dot"
        epwrname1$ = "Assault Rifle"
        epwr1$ = "Attack"
        epwrname2$ = "Sniper Rifle"
        epwr2$ = "Attack": GOTO 921
904 'CYTTORAX
        ename$ = "Cyttorax"
        epwrname1$ = "Energy Blast"
        epwr1$ = "Attack"
        epwrname2$ = "Beam"
        epwr2$ = "Attack": GOTO 921
905 'C WEEZY
        ename$ = "C Weezy"
        epwrname1$ = "Pimp Slap"
        epwr1$ = "Attack"
        epwrname2$ = "Blingage"
        epwr2$ = "Heal": GOTO 921
906 'SOUL FLAME
        ename$ = "Soul Flame"
        epwrname1$ = "Flame Slap"
        epwr1$ = "Attack"
        epwrname2$ = "Fiery Aura"
        epwr2$ = "Heal": GOTO 921
907 'MAGNANIMOUS MARVIN
        ename$ = "Magnanimous Marvin"
        epwrname1$ = "Screech"
        epwr1$ = "Attack"
        epwrname2$ = "Big Punch"
        epwr2$ = "Attack": GOTO 921
908 'CRATOR
        ename$ = "Crator"
        epwrname1$ = "Rock Kick"
        epwr1$ = "Attack"
        epwrname2$ = "Stone Skin"
        epwr2$ = "DmgRed": GOTO 921
909 'PARAGON DEFENSE BOT
        ename$ = "Paragon Defense Bot"
        epwrname1$ = "Self-Repair"
        epwr1$ = "Heal"
        epwrname2$ = "Electric Bolt"
        epwr2$ = "Attack": GOTO 921
910 'CITIZEN'S KID
        ename$ = "Citizen's Kid"
        epwrname1$ = "Yo-Yo"
        epwr1$ = "Attack"
        epwrname2$ = "Battle Axe"
        epwr2$ = "Attack": GOTO 921
911 'FOX
        ename$ = "Fox"
        epwrname1$ = "Bite"
        epwr1$ = "Attack"
        epwrname2$ = "Lick"
        epwr2$ = "Heal": GOTO 921
912 'GOBLIN
        ename$ = "Goblin"
        epwrname1$ = "Dagger"
        epwr1$ = "Attack"
        epwrname2$ = "Stone"
        epwr2$ = "Attack": GOTO 921
913 'TROLL
        ename$ = "Troll"
        epwrname1$ = "Scratch"
        epwr1$ = "Attack"
        epwrname2$ = "Mesmerize"
        epwr2$ = "DmgRed": GOTO 921
914 'ORC
        ename$ = "Orc"
        epwrname1$ = "Broad Sword"
        epwr1$ = "Attack"
        epwrname2$ = "Punch"
        epwr2$ = "Attack": GOTO 921
915 'ELF
        ename$ = "Elf"
        epwrname1$ = "Elven Bow"
        epwr1$ = "Attack"
        epwrname2$ = "Elven Magic"
        epwr2$ = "Heal": GOTO 921
916 'DWARF
        ename$ = "Dwarf"
        epwrname1$ = "War Mace"
        epwr1$ = "Attack"
        epwrname2$ = "War Hammer"
        epwr2$ = "Attack": GOTO 921
917 'BANDIT
        ename$ = "Bandit"
        epwrname1$ = "Swift Dagger"
        epwr1$ = "Attack"
        epwrname2$ = "Shadows"
        epwr2$ = "DmgRed": GOTO 921
918 'MARCUS RAGNATHA
        ename$ = "Marcus Ragnatha"
        epwrname1$ = "Northern Blade"
        epwr1$ = "Attack"
        epwrname2$ = "Energy Burst"
        epwr2$ = "Attack": GOTO 921
919 'WOLF
        ename$ = "Wolf"
        epwrname1$ = "Claw"
        epwr1$ = "Attack"
        epwrname2$ = "Growl"
        epwr2$ = "DmgRed": GOTO 921
920 'BEAR
        ename$ = "Bear"
        epwrname1$ = "Swat"
        epwr1$ = "Attack"
        epwrname2$ = "Maul"
        epwr2$ = "Attack": GOTO 921
921 GetEnemyName = ename$
END FUNCTION

SUB introduction
1000
PLAY "MB"
PLAY "c2L4eg<b.>l16cdl2c"
PLAY ">al4g>c<gl16fefl2e"
CLS
        LOCATE 4, 30: PRINT "*          *"
        LOCATE 6, 30: PRINT "*          *"
        SLEEP 1
        LOCATE 4, 30: PRINT "**        **"
        LOCATE 6, 30: PRINT "**        **"
        SLEEP 1
        LOCATE 4, 30: PRINT "***      ***"
        LOCATE 6, 30: PRINT "***      ***"
        SLEEP 1
        LOCATE 4, 30: PRINT "****    ****"
        LOCATE 6, 30: PRINT "****    ****"
        SLEEP 1
        LOCATE 4, 30: PRINT "*****  *****"
        LOCATE 6, 30: PRINT "*****  *****"
        SLEEP 1
        LOCATE 4, 30: PRINT "************"
        LOCATE 6, 30: PRINT "************"
        SLEEP 1
LOCATE 5, 32: PRINT "B      S"
SLEEP 1
LOCATE 5, 32: PRINT "BA    RS"
SLEEP 1
LOCATE 5, 32: PRINT "BAM  ARS"
SLEEP 1
LOCATE 5, 32: PRINT "BAM-WARS"
SLEEP 3

END SUB

SUB level (lvl%, hp%, vic%, pp%)
IF lvl% = 1 THEN GOTO lvl1
IF lvl% = 2 THEN GOTO lvl2
IF lvl% = 3 THEN GOTO lvl3
IF lvl% = 4 THEN GOTO lvl4
IF lvl% = 5 THEN GOTO lvl5
IF lvl% = 6 THEN GOTO lvl6
IF lvl% = 7 THEN GOTO lvl7
IF lvl% = 8 THEN GOTO lvl8
IF lvl% = 9 THEN GOTO lvl9
IF lvl% = 10 THEN GOTO lvl10
'------------------------------------------------------
lvl1:
        hp% = 10
        IF vic% = 2 THEN
                hp% = hp% + 5
                vic% = 0
                lvl% = 2
                pp% = pp% + 2
        END IF
        GOTO endlvl
lvl2:
        hp% = 15
        IF vic% = 3 THEN
                hp% = hp% + 5
                vic% = 0
                lvl% = 3
                pp% = pp% + 2
        END IF
        GOTO endlvl
lvl3:
        hp% = 20
        IF vic% = 4 THEN
                hp% = hp% + 5
                vic% = 0
                lvl% = 4
                pp% = pp% + 2
        END IF
        GOTO endlvl
lvl4:
        hp% = 25
        IF vic% = 5 THEN
                hp% = hp% + 5
                vic% = 0
                lvl% = 5
                pp% = pp% + 3
        END IF
        GOTO endlvl
lvl5:
        hp% = 30
        IF vic% = 6 THEN
                hp% = hp% + 5
                vic% = 0
                lvl% = 6
                pp% = pp% + 3
        END IF
        GOTO endlvl
lvl6:
        hp% = 35
        IF vic% = 7 THEN
                hp% = hp% + 5
                vic% = 0
                lvl% = 7
                pp% = pp% + 3
        END IF
        GOTO endlvl
lvl7:
        hp% = 40
        IF vic% = 8 THEN
                hp% = hp% + 5
                vic% = 0
                lvl% = 8
                pp% = pp% + 4
        END IF
        GOTO endlvl
lvl8:
        hp% = 45
        IF vic% = 9 THEN
                hp% = hp% + 5
                vic% = 0
                lvl% = 9
                pp% = pp% + 4
        END IF
        GOTO endlvl
lvl9:
        hp% = 50
        IF vic% = 10 THEN
                hp% = hp% + 5
                vic% = 0
                lvl% = 10
                pp% = pp% + 4
        END IF
        GOTO endlvl
lvl10:
        hp% = 55
        IF vic% = 15 THEN
                hp% = hp% + 5
                vic% = 0
                lvl% = 11
                pp% = pp% + 5
        END IF
        GOTO endlvl
endlvl:

END SUB

SUB MainMenu (name$, pwrname1$, pwr1$, pwrname2$, pwr2$, hp%, lvl%, pp%, vic%, pnt1%, pnt2%)
1299 CLS
LOCATE 3, 20: PRINT "What would you like to do from here?"
LOCATE 4, 20: PRINT "       View (View Statistics)"
LOCATE 5, 20: PRINT "       Fight (Begin fighting)"
LOCATE 6, 20: PRINT "          Save (Save Game)"
LOCATE 7, 20: PRINT "          Load (Load Game)"
LOCATE 8, 30: INPUT "", choice$
        choice$ = UCASE$(choice$)
        IF choice$ = "VIEW" THEN GOTO 1300
        IF choice$ = "FIGHT" THEN GOTO 1350
        IF choice$ = "LOAD" THEN GOTO 21100
        IF choice$ = "SAVE" THEN
                svname$ = LTRIM$(name$)
                svname$ = RTRIM$(svname$)
                svname$ = (LEFT$(UCASE$(svname$), 4))
                filename$ = "c:\" + svname$ + ".dat"
                OPEN "O", #1, filename$
                ON ERROR GOTO 0
                WRITE #1, name$, pwrname1$, pwr1$, pwrname2$, pwr2$, hp%, lvl%, pp%, vic%, pnt1%, pnt2%
                CLOSE #1
        END IF
        IF choice$ <> "END" THEN GOTO 1299
        IF choice$ = "END" THEN END
onerror:
        GOTO 1299

21100 LOCATE 14, 25: PRINT "Type first 4 letters"
LOCATE 15, 25: PRINT " of character's name."
LOCATE 16, 20: INPUT "   ", cchar$
charfile$ = "c:\" + cchar$ + ".dat"
OPEN "I", #2, charfile$
INPUT #2, name$, pwrname1$, pwr1$, pwrname2$, pwr2$, hp%, lvl%, pp%, vic%, pnt1%, pnt2%
CLOSE #2
CALL MainMenu(name$, pwrname1$, pwr1$, pwrname2$, pwr2$, hp%, lvl%, pp%, vic%, pnt1%, pnt2%)

' View Statistics
1300 CLS
LOCATE 4, 30: PRINT "Name: "; name$
LOCATE 5, 25: PRINT "Power 1: "; pwrname1$; " ("; pwr1$; ") ["; pnt1%; "]"
LOCATE 6, 25: PRINT "Power 2: "; pwrname2$; " ("; pwr2$; ") ["; pnt2%; "]"
LOCATE 7, 30: PRINT "Level: "; lvl%
LOCATE 8, 30: PRINT "Health: "; hp%
LOCATE 9, 30: PRINT "Points: "; pp%
LOCATE 10, 30: PRINT "Victories: "; vic%
        IF pp% > 0 THEN
                LOCATE 11, 20: PRINT "Type ADD to allocate points."
        END IF
INPUT "", viewmenu$
viewmenu$ = UCASE$(viewmenu$)
IF viewmenu$ = "ADD" THEN CALL allocate(pp%, pnt1%, pnt2%, pwrname1$, pwrname2$)
GOTO 1299
1350 CALL fight(name$, pwrname1$, pwr1$, pwrname2$, pwr2$, hp%, lvl%, pp%, vic%, pnt1%, pnt2%)
END SUB

FUNCTION rps$ (hand1$, hand2$, outcome%)
70 RANDOMIZE TIMER
x% = INT(RND * 3) + 1
y% = INT(RND * 3) + 1
IF x% = 1 THEN hand1$ = "Rock"
IF x% = 2 THEN hand1$ = "Paper"
IF x% = 3 THEN hand1$ = "Scissors"
IF y% = 1 THEN hand2$ = "Rock"
IF y% = 2 THEN hand2$ = "Paper"
IF y% = 3 THEN hand2$ = "Scissors"
IF x% = y% THEN GOTO 70
IF x% = 1 AND y% = 2 THEN GOTO 73    '1: Rock     2: Paper
IF x% = 1 AND y% = 3 THEN GOTO 72    '1: Rock     2: Scissors
IF x% = 2 AND y% = 3 THEN GOTO 73    '1: Paper    2: Scissors
IF x% = 2 AND y% = 1 THEN GOTO 72    '1: Paper    2: Rock
IF x% = 3 AND y% = 1 THEN GOTO 73    '1: Scissors 2: Rock
IF x% = 3 AND y% = 2 THEN GOTO 72    '1: Scissors 2: Paper
72 outcome% = 1: GOTO 74
73 outcome% = 2: GOTO 74
74 rps$ = hand1$
END FUNCTION

SUB SetEnemyStats (lvl%, ehp%, elvl%, epnt1%, epnt2%)
9999 RANDOMIZE TIMER
estat% = INT(RND * 100) + 1
        IF estat% < 2 THEN GOTO 10000
        IF estat% < 3 THEN GOTO 10001
        IF estat% < 20 THEN GOTO 10002
        IF estat% < 61 THEN GOTO 10003
        IF estat% < 101 THEN GOTO 10004
'enemy is +2 levels
10000 elvl% = lvl% + 2
GOTO 10005
'enemy is -2 levels
10001 elvl% = lvl% - 2
GOTO 10005
'enemy is +1 level
10002 elvl% = lvl% + 1
GOTO 10005
'enemy is -1 level
10003 elvl% = lvl% - 1
GOTO 10005
'enemy is on level with character
10004 elvl% = lvl%
GOTO 10005
IF elvl% = 0 THEN GOTO 9999
10005 :
        IF elvl% = 1 THEN ehp% = 10
        IF elvl% = 2 THEN ehp% = 15
        IF elvl% = 3 THEN ehp% = 20
        IF elvl% = 4 THEN ehp% = 25
        IF elvl% = 5 THEN ehp% = 30
        IF elvl% = 6 THEN ehp% = 35
        IF elvl% = 7 THEN ehp% = 40
        IF elvl% = 8 THEN ehp% = 45
        IF elvl% = 9 THEN ehp% = 50
        IF elvl% = 10 THEN ehp% = 55
setattacks:
        IF elvl% = 1 THEN
                epp% = 10
                epnt1% = INT(RND * 9) + 1
                epnt2% = INT(RND * 9) + 1
        END IF
        IF elvl% = 2 THEN
                epp% = 12
                epnt1% = INT(RND * 11) + 1
                epnt2% = INT(RND * 11) + 1
        END IF
        IF elvl% = 3 THEN
                epp% = 14
                epnt1% = INT(RND * 13) + 1
                epnt2% = INT(RND * 13) + 1
        END IF
        IF elvl% = 4 THEN
                epp% = 16
                epnt1% = INT(RND * 15) + 1
                epnt2% = INT(RND * 15) + 1
        END IF

        IF elvl% = 5 THEN
                epp% = 19
                epnt1% = INT(RND * 18) + 1
                epnt2% = INT(RND * 18) + 1
        END IF
        IF elvl% = 6 THEN
                epp% = 22
                epnt1% = INT(RND * 21) + 1
                epnt2% = INT(RND * 21) + 1
        END IF
        IF elvl% = 7 THEN
                epp% = 25
                epnt1% = INT(RND * 24) + 1
                epnt2% = INT(RND * 24) + 1
        END IF
        IF elvl% = 8 THEN
                epp% = 29
                epnt1% = INT(RND * 28) + 1
                epnt2% = INT(RND * 28) + 1
        END IF
        IF elvl% = 9 THEN
                epp% = 33
                epnt1% = INT(RND * 32) + 1
                epnt2% = INT(RND * 32) + 1
        END IF
        IF elvl% = 10 THEN
                epp% = 37
                epnt1% = INT(RND * 36) + 1
                epnt2% = INT(RND * 36) + 1
        END IF

IF epp% <> epnt1% + epnt2% THEN GOTO setattacks


endstats:
END SUB

SUB startmenu
1999 CLS
LOCATE 4, 20: PRINT "    START MENU:"
LOCATE 5, 20: PRINT "       New"
LOCATE 6, 20: PRINT " (Starts new game)"
LOCATE 7, 20: PRINT "       Load"
LOCATE 8, 20: PRINT "(Loads up saved game)"
LOCATE 9, 20: PRINT "       Quit"
LOCATE 10, 20: PRINT "---------------------"
LOCATE 11, 20: INPUT "   ", sm$
        sm$ = UCASE$(sm$)
        IF sm$ = "NEW" THEN GOTO 2000
        IF sm$ = "LOAD" THEN GOTO 2100
        IF sm$ <> "QUIT" THEN GOTO 1999
        IF sm$ = "QUIT" THEN END
2100 LOCATE 14, 20: PRINT "Enter First 4 Letters"
LOCATE 15, 20: PRINT "in character's name."
LOCATE 16, 20: INPUT "   ", cchar$
charfile$ = "c:\" + cchar$ + ".dat"
OPEN "I", #2, charfile$
INPUT #2, name$, pwrname1$, pwr1$, pwrname2$, pwr2$, hp%, lvl%, pp%, vic%, pnt1%, pnt2%
CLOSE #2
CALL MainMenu(name$, pwrname1$, pwr1$, pwrname2$, pwr2$, hp%, lvl%, pp%, vic%, pnt1%, pnt2%)
2000
END SUB
