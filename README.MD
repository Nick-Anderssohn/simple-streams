Simple streams is designed to make triggering and listening to events simple.
Its goal is to help avoid memory leaks and keep code clean at the same time.

Should be used soley for event streams (or somewhere you would normally use a broadcast stream in dart)
(i.e. you wanted to make your own onClick or something similar).
Not meant for other streaming purposes.

Source code: https://github.com/Nick-Anderssohn/simple-streams

See the example in the test folder.

Installing:

Add this to the pubsepc.yaml

dependencies:
  
  simple_streams: 
