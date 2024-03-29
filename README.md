# Wirst-Watch-using-VHDL-
   Design a multifunction wristwatch that has three main modes: Time, Alarm and stop watch. The wristwatch has three buttons (B1, B2, and B3) that are used to change the mode, set the time, set the alarm, start and stop the stopwatch, and so on. 
   
   Button B1: Pressing it changes the mode from Time to Alarm to Stopwatch and back to Time. The functions of buttons B2 and B3 vary depending on the mode. 
              
Operation in time mode: Display indicates the time and whether it is A.M. or P.M. using the format hh:mm:ss (A or P). When in time mode, the alarm can be shut off manually by pressing B3. Pushing B2 changes the state to Set Hours or Set Minutes and back to Time mode. When in the Set Hours or Set Minutes state, each press of B3 advances the hours or minutes by 1. 

Operation in alarm mode: Display indicates the alarm time and whether it is A.M. or P.M. using the format hh:mm (A or P). Pushing B2 changes the state to Set Alarm Hours or Set Alarm Minutes and then back to Alarm. When in the Set Alarm Hours or Set Alarm Minutes state, each press of B3 advances the alarm hours or minutes by 1. When in the Alarm state, pressing B3 sets or resets the alarm. Once the alarm starts ringing, it will ring for 50 seconds and then shut itself off. It can also be shut off manually by pressing B3 in time mode. 

Operation in the stopwatch mode: Display indicates stopwatch time in the format mm:ss.cc (where cc is hundredths of a second). Pressing B2 starts the time counter, pressing B2 again stops it, and then pressing B2 restarts it, and so on. Pressing B3 resets the time. Once the stopwatch is started, it will keep running even when the wristwatch is in time or alarm mode.
