README.MD for CBML and SaxonJS demo
---

John A. Walsh   
<mailto:jawalsh@indiana.edu>

# Files and directories

* `fantastic_comics_15.xml`: TEI/XML source file with partial edited transcription of _Fantastic Comics_ #15 (Feburary 1941). See <https://www.comics.org/issue/1259/>.

* `index.html`: “static skeleton” HTML page into which the output of the XSLT transformation is inserted. See <https://www.saxonica.com/saxon-js/documentation2/index.html#!browser/result-documents>.

* `cbml2htmlJs.xsl`: XSLT stylesheet to transform the `fantastic_comics_15.xml` TEI/XML document into HTML. The XSLT is written to work with SaxonJS, a JavaScript XSLT 3.0 processor. See <https://www.saxonica.com/saxon-js/index.xml>.

* `cbml2htmlJs.sef.json`: The “compiled” version of the cbml2htmlJs.xsl` XSLT stylesheet, for use with the SaxonJS XSLT 3.0 processor. See <https://www.saxonica.com/saxon-js/documentation2/index.html#!starting/export>.

* `cbml.css`: CSS stylesheet for HTML version of document, which is the output of the XSLT transformation.

* `js` directory: SaxonJS. SaxonJS can be downloaded from <https://saxonica.com/>.