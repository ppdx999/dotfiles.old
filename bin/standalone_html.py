#!/usr/bin/env python3

import os
import sys
from bs4 import BeautifulSoup
import mimetypes
import markdown
from jinja2 import Template

"""
# toHtml
"""


def toHtml(md: str) -> str:
    writer = markdown.Markdown(extensions=['fenced_code', 'tables'])
    return writer.convert(md)


"""
# templatize
"""


def templatize(title: str, body: str) -> str:
    template_html = """
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <title>{{ title }}</title>
    <style>
    @media print{*,:after,:before{background:transparent!important;color:#000!important;box-shadow:none!important;text-shadow:none!important}a,a:visited{text-decoration:underline}a[href]:after{content:" (" attr(href) ")"}abbr[title]:after{content:" (" attr(title) ")"}a[href^="#"]:after,a[href^="javascript:"]:after{content:""}blockquote,pre{border:1px solid #999;page-break-inside:avoid}thead{display:table-header-group}img,tr{page-break-inside:avoid}img{max-width:100%!important}h2,h3,p{orphans:3;widows:3}h2,h3{page-break-after:avoid}}code,pre{font-family:Menlo,Monaco,Courier New,monospace}pre{padding:.5rem;line-height:1.25;overflow-x:scroll}a,a:visited{color:#3498db}a:active,a:focus,a:hover{color:#2980b9}.modest-no-decoration{text-decoration:none}html{font-size:9pt}@media screen and (min-width:32rem) and (max-width:60rem){html{font-size:15px}}@media screen and (min-width:60rem){html{font-size:1pc}}body{line-height:1.85}.modest-p,p{font-size:1rem;margin-bottom:1.3rem}.modest-h1,.modest-h2,.modest-h3,.modest-h4,h1,h2,h3,h4{margin:1.414rem 0 .5rem;font-weight:inherit;line-height:1.42}.modest-h1,h1{margin-top:0;font-size:3.998rem}.modest-h2,h2{font-size:2.827rem}.modest-h3,h3{font-size:1.999rem}.modest-h4,h4{font-size:1.414rem}.modest-h5,h5{font-size:1.121rem}.modest-h6,h6{font-size:.88rem}.modest-small,small{font-size:.707em}@import url(http://fonts.googleapis.com/css?family=Open+Sans+Condensed:300,300italic,700);@import url(http://fonts.googleapis.com/css?family=Arimo:700,700italic);canvas,html,iframe,img,select,svg,textarea,video{max-width:100%}html{font-size:18px}body{color:#444;font-family:Open Sans Condensed,sans-serif;font-weight:300;margin:0 auto;max-width:60rem;line-height:1.45;padding:.25rem}h1,h2,h3,h4,h5,h6{font-family:Arimo,Helvetica,sans-serif}h1,h2,h3{border-bottom:2px solid #fafafa;margin-bottom:1.15rem;padding-bottom:.5rem}h1{text-align:center}h2{border-bottom:1px solid #444}blockquote{border-left:8px solid #fafafa;padding:1rem}code,pre{background-color:#fafafa}
    </style>
  </head>
  <body>
    {{ body }}
  </body>
</html>
    """
    tmpl = Template(template_html)

    data = {"title": title, "body": body, }
    return tmpl.render(data)


"""
# make_html_iamges_inline
"""


def file_to_base64(filepath: str) -> str:
    import base64
    with open(filepath, 'rb') as f:
        encoded_str = base64.b64encode(f.read())
    return encoded_str.decode('utf-8')


def make_html_images_inline(basepath: str, html: str) -> str:
    soup = BeautifulSoup(html, 'html.parser')
    for img in soup.find_all('img'):
        img_path = os.path.join(basepath, img.attrs['src'])
        mimetype = mimetypes.guess_type(img_path)[0]
        img.attrs['src'] = \
            "data:%s;base64,%s" % (mimetype, file_to_base64(img_path))
    return str(soup)


if __name__ == '__main__':
    input_file = sys.argv[1]
    basepath = os.path.split(input_file.rstrip(os.path.sep))[0]

    with open(input_file) as f:
        md: str = f.read()

    sys.stdout.write(make_html_images_inline(
        basepath, templatize(input_file, toHtml(md))))
