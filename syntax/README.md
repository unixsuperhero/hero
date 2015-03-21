
# hero-syntax

This hero project is for experimenting with the document format I want to use
for `notes` and `tasks`.

## goals

The goal is to use a simple format that avoids getting
in the way of the user's preferred document format.

To accomplish this, we are using the first set of lines for key/value pairs for
defining metadata.  The first non-key-pair line will be used as a title.
Everything after that is fair game.  The only other elements that are extracted
from the document are hashtags: #listthis.

By creating an independent project out of this, I want to accomplish a few
things from within this directory:

1. Command-line parsing tools
2. Vim support (via plugins with mappings, syntax highlighting, etc.)

## vim support

Mappings:

* jumping to an "index" document/file listing all files related to the hashtag
  under the cursor


Functions:

* commands for creating a new note either from the whole file, or from the
  visually selected lines
  * ideally, i want users to be able to setup multiple notes within a scratch
    file, and save them 1-by-1.
  * pipe a visual selection to a command using: `:'<,'>w !herodoc parse`

