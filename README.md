The maison Jeanne Lanvin is the oldest couture house still active today. Its story begin in 1885 when Jeanne Lanvin starts working on rue du Marché-Saint-Honoré as a milliner. By 1893, at just 22, she had her first shop at 22 rue du Faubourg-Saint-Honoré. Lanvin soon became a major influence in early 20th-century Parisian fashion, alongside designers like Paul Poiret, Coco Chanel, and Madeleine Vionnet. Notably, she pioneered menswear by launching one of the first collections for men, which is a key reason for my interest in the house.

Jeanne Lanvin was also deeply invested in preserving her legacy, storing over 500 dresses, many samples, photographs, and documents in the attic above her workshops. These archives, discovered in the 1980s, led to the establishment of the Lanvin Heritage department.

I selected four letters, two of which are shorter than the guideline length: a typed invoice from 1912, a typed customer correspondence from 1923, a handwritten customer correspondence from 1930, and a typed letter to a friend from 1931. Each document reveals facets of the early 20th-century fashion industry. Moreover, the evolution of the letterheads reflects technological advances with the advent of the telegraph and then the telephone, as well as the emergence of Lanvin's famous mother-and-child logo in 1924, symbolizing her bond with her daughter Marguerite. The list of boutiques also traces the brand’s expansion over time.

Following Peter Copping’s recent appointment as artistic director, a major exhibition on Lanvin's impact on 20th-century fashion is planned at the Palais Galliera. This event will be inaugurated with a scientific symposium featuring publications on the maison. Key documents from the Lanvin Heritage department are therefore being digitized in XML format to enhance researchers’ access to the data.

To convert my TEI XML document into a .tex file and then into a PDF, I used the following commands:
xsltproc -o Jeanne_Lanvin_1931.tex SABIN_Thibault_XSL.xsl Jeanne_Lanvin_1931_XML.xml
pdflatex Jeanne_Lanvin_1931.tex
