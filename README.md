# A LOoper

![screenshot](/source/alo.lv2/modgui/screenshot-alo.png)

ALO is an LV2 plugin primarily targeted at the MOD Duo but hopefully it should
work on other systems too. It's based on the amp.c and metro.c lv2 example
plugins, plus some study of the loopor code.

The idea is to provide an easy, mistake-proof way to create and trigger live
music loops in sync with a click track, or in free running mode.

- Each instance of ALO can record and play up to 6 loops. All loops are the
  same length.

- In sync mode the loop length is set by the ```Bars``` parameter.

- In free running mode, the loop length is set when a switch is pressed to mark
  the end of recording the first loop.

- Each loop is recorded/played using a switch by default.

- Alternatively you can connect a MIDI device and use MIDI notes to control
  the loops. The ```MIDI Base``` parameter sets the range of midi notes (from
  ```MIDI Base``` to ```MIDI Base + 5```) assigned to loops.

- Each loop start point is triggered when the audio input signal crosses the
 ```Threshold``` value.

- Hit a switch (or a MIDI note on) to arm a loop, then start playing to begin
  recording. Hit the switch again (or MIDI note off) to mute the loop once it
  finishes playing. Hit again (or MIDI note on again) to start playing the
  loop again next time around.

- Each loop is a single recording. To 'overdub', just record another loop.

- To reset a loop, for re-recording, double-hit the switch (or toggle the midi
  note) within one second.

- In free running mode, turning all loops off will reset them all.

- The ```Click``` parameter adjusts the click volume in sync mode. Set it to
  zero if you're using something else as a click track.

- The ```Mix``` parameter adjusts the relativel levels of the dry signal and
  loop signals. 100 is loops only, 0 is dry signal only.

- If you want more loops, or different loop lengths, add extra instances of Alo.

## design notes
```
              1       2       3       4       1       2
.-|-.-.-.-|-.-.-.-|-.-.-.-|-.-.-.-|-.-.-.-|-.-.-.-|-.-.-.   beats

<------always recording in the background--------------->

_______/<<^^^^^^^^^^^^^^^^^^^\____________________________  audio in
       |<<| phrase-start..goes here--> |<<|

      |^^^^^^^| hit loop button anytime in this region
                now we know loop starts at nearest beat 1 
                and threshold detect for intro phrase
          |^^^^^^^^^^^^^^^^^^^\_________<<|     loop is fixed length
                                       |  |     includes phrase-start
```

- we start in 'recording' mode

- when loop button is pressed:

  if 'recording' mode:
    - figure out when phrase-start happens
    - switch to loop_on mode at next phrase_start

  if loop_on mode:
    - play the loop from (and looping at) next phrase-start

  if loop_off mode:
    - stop playing loop at next phrase-start

  - if button is pressed twice within one beat, go back to 'recording' mode

## starting MOD docker build environment

```
cd <path to alo source>
docker buildx build -o /tmp/alo .
```

## build and deploy notes

```./cycle.sh```

## debug notes

```

edit the code to set `LOG_ENABLED = true`

```
tail -f /root/alo.log`

mod-host -p 1234 -i
add http://devcurmudgeon.com/alo 0
````
