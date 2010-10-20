gemedit
  http://gemedit.rubyforge.org/
  by Lee Marlow

== DESCRIPTION:

Gemedit lets you quickly open up the source for a gem in your favorite editor.

Looking through other people's code is a great way to learn.  I often use it when a gem's RDoc isn't as helpful as I'd like or just want to see how someone put a library together.  Gemedit just makes it easier to get to the code.

== INSTALLATION:

Gemedit can be installed via RubyGems:

  $ sudo gem install gemedit

== USAGE:

If you want to see how gemedit works just install it and run this:
  $ gem edit gemedit

Gemedit tries to use your favorite editor from your <tt>$GEMEDITOR</tt>, <tt>$VISUAL</tt> or <tt>$EDITOR</tt> environment variable.  It will fall back to <em>everyone's</em> favorite editor: *vi*.  You can specify the editor with the <tt>-e/--editor</tt> switch.  Run this to view the source for +rake+ in TextMate[http://macromates.com]:
  $ gem edit -e mate rake

And of course, help is available:
  $ gem edit -h
  $ gem edit --help

== DOCUMENTATION:

There isn't much more to document than what is on this page, but feel free to browse the RDoc[http://gemedit.rubyforge.org/rdoc/].  Or checkout the Rubyforge project page here[http://rubyforge.org/projects/gemedit/].

== SOURCE REPOSITORY:

The source is currently on github[http://github.com/].  You can browse through it at http://github.com/lmarlow/gemedit or pull it down and play with it yourself with 

  $ git clone git://github.com/lmarlow/gemedit.git
