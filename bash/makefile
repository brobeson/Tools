# setup: vpath, variables, etc {{{

# In this section, set the variables to suit your project.

# outputDir is the directory which should contain the final documents.
outputDir						:= build/doc

# intDir is the directory which should contain any intermediate files
# generated by the commands. Examples include auxilliary files created
# by your LaTeX distribution, diagrams exported to an ingestible format,
# etc.
intDir							:= obj/doc

# The imageIntDir is the directory to put intermediate image files.
# Usually, this will be $(intDir), or a subdirectory.
imageIntDir						:= $(intDir)/images

# The diagramExportOptions are the options to be passed to your
# diagram exporting tool. The default options are for Dia and
# specify not to show the splash screen, and to export to EPS
# format.
diagramExportOptions			:= --nosplash -t eps

# diagramExport is the diagram exporting tool you plan to use. You
# should include the diagram exporting options defined above. The
# default is to use Dia.
diagramExport					:= dia $(diagramExportOptions)

# The renderOptions are any options to be passed to your document
# rendering tool. The defaults are set for pdflatex, the default
# renderer (defined below).
renderOptions					:= -aux-directory=$(intDir) -c-style-errors -disable-installer -output-directory=$(outputDir)

# The render variable holds the command to render your document source
# to the final format. The default is pdflatex, to render from LaTeX to
# PDF.
render							:= pdflatex $(renderOptions)

# The sourceDir variable tells make where to find the documentation
# source files.
sourceDir						:= documentation

vpath %.pdf $(outputDir)
vpath %.tex $(sourceDir)
vpath %.dia $(sourceDir)/images
vpath %.eps $(sourceDir)/images $(imageIntDir)
# }}}

# targets - all, rebuild, clean, help {{{
#
# For the all target, list each engineering document, without the extension. For
# example, you have the documents requirements.pdf, design.pdf, and test.pdf.
# Set up the all target like this:
#	.PHONY: all
#	all: requirements design test
# Then, for each of those prerequisites, create a phony target which depends on
# the actual document you want to produce:
#	.PHONY: requirements
#	requirements: requirements.pdf
# This structure allows the user to run
# 	$ make requirements
#
#.PHONY: all
#all:

.PHONY: rerender
rebuild: clean all

.PHONY: clean
clean:
	@find $(outputDir) -name *.pdf -delete
	@find $(intDir) -type f -delete
	@find $(sourceDir) -name *.dia~ -delete
	@echo "This house is clean."

.PHONY: help
help:
	@echo "Name"
	@echo "    ./makefile - render engineering documentation to PDF format"
	@echo
	@echo "Synopsis"
	@echo "    make [target]"
	@echo
	@echo "Description"
	@echo "    This make file is used to render engineering documentation to PDF format."
	@echo "    The documents are typically in LaTeX, diagrams are in Dia, and other images"
	@echo "    are in EPS formats. However, you can use whateve you want to, so long as"
	@echo "    necessary conversions can be scripted."
	@echo
	@echo "    Note that you do not need to run this make file twice to resolve LaTeX cross"
	@echo "    references. The make file does that automatically."
	@echo
	@echo "Variables"
	@echo "    A number of variables are defined at the top of the make file. The goal is"
	@echo "    to make this somewhat of a template which can be adapted to different tools"
	@echo "    and file types. For complete information about the variables, it's best to"
	@echo "    just read the file. You can make the target 'config' to see their values."
	@echo
	@echo "Targets"
	@echo "    all           [default] This target makes everything which is out of date."
	@echo "    clean         Delete all the intermediate and output files."
	@echo "    config        View the values of the configuration variables."
	@echo "    diagrams      Convert all the Dia diagrams to EPS files."
	@echo "    help          Print this help."
	@echo "    rerender      This target cleans the intermediate and output files, then"
	@echo "                  makes everything."
	@echo
	@echo "Author"
	@echo "    Brendan Robeson    https://github.com/brobeson/Tools"
	@echo

.PHONY: config
config:
	@echo "diagramExport        " $(diagramExport)
	@echo "diagramExportOptions " $(diagramExportOptions)
	@echo "imageIntDir          " $(imageIntDir)
	@echo "intDir               " $(intDir)
	@echo "outputDir            " $(outputDir)
	@echo "render               " $(render)
	@echo "renderOptions        " $(renderOptions)
	@echo "sourceDir            " $(sourceDir)
#}}}

# the targets for the documents {{{
# note that the pdflatex is run twice for each document. this is to get
# the cross references correct.
#
# The pattern I use is thus:
# 1 - Create a phony target using the document stem, which is dependent on the
#     output file.
# 2 - Create a target for $(outputDir)/outputFile, which is dependent on whatever
#     it needs.
# The advantage to this is that one can type "make document" to render just
# that document. Below is an example for a design document. This example also
# shows the use of the diagrams target to convert diagrams from a diagram tool's
# native format to something LaTeX can render.
#
#.PHONY: design
#design: design.pdf
#	@echo "The design render is complete."
#
#$(outputDir)/design.pdf:	design.tex	\
#							image1.eps	\
#							image2.eps	\
#							diagrams
#	@$(render) $<
#	@$(render) $<
#}}}

# the targets for dia diagrams {{{
#
# Here you can convert diagrams from one format to another. This is typically
# used to convert from a diagram tool's native format to something the document
# renderer can use. For example, I use Dia to draw UML diagrams, and export them
# to EPS, which LaTeX can render into a document.
#
# In the diagrams target, just list all the diagrams to convert. If you want
# more control, you could have diagrams targets for each document type:
# requirementsDiagrams, designDiagrams, testDiagrams, etc.
#
# I don't use a pattern rule here, because often the command script is slightly
# different from file to file. An example would be a Dia diagram, which uses
# different layers to illustrate different aspects of a system.
#
# You can use the diagrams example below as a guide.

.PHONY: rediagram
rediagram: clean diagrams

#.PHONY: diagrams
#diagrams:	uml-class-diagram-1.eps \
#			uml-class-diagram-2.eps \
#			uml-sequence-diagram.eps
#
#$(imageIntDir)/uml-class-diagram-1.eps: uml-class-diagram.dia
#	@$(diagramExport) --show-layers=Background,inheritance --export=$@ $<
#$(imageIntDir)/uml-class-diagram-2.eps: uml-class-diagram.dia
#	@$(diagramExport) --show-layers=Background,aggregation --export=$@ $<
#$(imageIntDir)/uml-sequence-diagram.eps: uml-sequence-diagram.dia
#	@$(diagramExport) --export=$@ $<
#}}}

