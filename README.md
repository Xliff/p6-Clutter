# p6-Clutter

# INSTALLATION

Make a directory to contain the p6-Gtk-based projects. Once made, then set the P6_GTK_HOME environment variable to that directory:

```
$ export P6_GTK_HOME=/path/to/projects
```

Switch to that directory and clone both p6-GtkPlus and p6-Clutter

```
$ git clone https://github.com/Xliff/p6-GtkPlus.git
$ git clone https://github.com/Xliff/p6-Clutter.git
```

[Optional] To build all of Clutter and the required GTK modules, you can change to the p6-Clutter directory and do:

```
./build.sh
```

If you just want to run the examples, you can do: 

```
./p6gtkexec t/<name of example>
```

Unfortunately, compile times are very long for this project, but I hope you find it interesting!

