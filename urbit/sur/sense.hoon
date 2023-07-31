|%
::  Basic types of data
::
+$  point  [wifi=@ rco2=@ pm02=@ tvoc=@ nox=@ atmp=@ rhum=@]
::  Poke Actions
::
+$  action
  $%  [%add time=@da =point]
      [%del time=@da]
  ==
::  Types for updates to subscribers or returned via scries
::
+$  entry  [time=@da =point]
+$  update
  %+  pair  @
    [%data list=(list entry)]
::  Types for agent state
+$  data  ((mop @ point) gth)
+$  log   ((mop @ action) gth)
--
