#!/bin/sh

awk '{print "<entities><decimal>"$4"</decimal><unicode>"$2"</unicode></entities>"}' entities-complete.xml >> test.xml