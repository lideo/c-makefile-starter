# God bless: 
# https://www.gnu.org/software/make/manual/make.html
# http://nuclear.mutantstargoat.com/articles/make/
# http://www.cs.colby.edu/maxwell/courses/tutorials/maketutor/
# https://www.tutorialspoint.com/cprogramming/c_header_files.htm
# https://stackoverflow.com/a/40621556

# Syntax
# gcc [options] [source files] [object files] -o output file
# -g option enables debugging mode 
# -c flag generates object code for separate files

SDIR = ./src
ODIR = ./objs
LDIR = ./lib
IDIR = ./include
BDIR = ./bin

CC = gcc

CFLAGS = -I$(IDIR)
LDFLAGS = $(libgl) -lpng -lz -lm

ifeq ($(shell uname -s), Darwin)
    libgl = -framework OpenGL -framework GLUT
else
    libgl = -lGL -lglut
endif

DEPS = $(wildcard $(IDIR)/*.h)
SOURCES = $(wildcard $(SDIR)/*.c)
OBJECTS = $(patsubst $(SDIR)/%.c, $(ODIR)/%.o, $(SOURCES))

$(BDIR)/hello: $(OBJECTS)
	$(CC) -g -o $@ $^ $(CFLAGS) $(LDFLAGS)

$(ODIR)/%.o: $(SDIR)/%.c $(DEPS)
	$(CC) -g -c -o $@ $< $(CFLAGS)	

.PHONY: clean
clean:
	rm -f $(ODIR)/*.o *~ core $(INCDIR)/*~ $(BDIR)/*