"""Build the shareable PDF. Requires reportlab; no phone connection needed.

py -m pip install reportlab
py samsung-setup/scripts/Build-Guide.py
"""
from pathlib import Path
import argparse
import re
from xml.sax.saxutils import escape

from reportlab.lib import colors
from reportlab.lib.enums import TA_LEFT
from reportlab.lib.pagesizes import A4
from reportlab.lib.styles import ParagraphStyle, getSampleStyleSheet
from reportlab.lib.units import mm
from reportlab.pdfbase import pdfmetrics
from reportlab.pdfbase.ttfonts import TTFont
from reportlab.platypus import SimpleDocTemplate, Paragraph, Spacer, PageBreak, Preformatted

ROOT = Path(__file__).resolve().parents[1]

def build(source, output, append=None):
    fonts = Path('C:/Windows/Fonts')
    if (fonts / 'arial.ttf').exists():
        pdfmetrics.registerFont(TTFont('Guide', str(fonts / 'arial.ttf')))
        pdfmetrics.registerFont(TTFont('GuideBold', str(fonts / 'arialbd.ttf')))
        pdfmetrics.registerFontFamily('Guide', normal='Guide', bold='GuideBold')
        font, bold = 'Guide', 'GuideBold'
    else:
        font, bold = 'Helvetica', 'Helvetica-Bold'
    styles = getSampleStyleSheet()
    styles.add(ParagraphStyle(name='BodyGuide', fontName=font, fontSize=10.2,
                              leading=15, spaceAfter=9, splitLongWords=True))
    styles.add(ParagraphStyle(name='TitleGuide', fontName=bold, fontSize=23,
                              leading=29, textColor=colors.HexColor('#123b58'), spaceAfter=15))
    styles.add(ParagraphStyle(name='HeadingGuide', fontName=bold, fontSize=14,
                              leading=19, spaceBefore=14, spaceAfter=9, keepWithNext=True,
                              textColor=colors.HexColor('#123b58')))
    code_style = ParagraphStyle(name='CodeGuide', fontName='Courier', fontSize=9,
                               leading=12, leftIndent=8, spaceAfter=10,
                               backColor=colors.HexColor('#f0f4f7'))

    def inline(text):
        text = escape(text)
        if re.fullmatch(r'https?://\S+', text):
            return f'<link href="{text}" color="#176a95">{text}</link>'
        text = re.sub(r'\[([^\]]+)\]\((https?://[^)]+)\)',
                      r'<link href="\2" color="#176a95">\1</link>', text)
        text = re.sub(r'\*\*([^*]+)\*\*', r'<b>\1</b>', text)
        text = re.sub(r'`([^`]+)`', r'<font name="Courier">\1</font>', text)
        return text

    flow = []
    def render(path):
        paragraph, code, in_code = [], [], False
        def flush():
            if paragraph:
                flow.append(Paragraph(inline(' '.join(paragraph)), styles['BodyGuide']))
                paragraph.clear()
        for line in path.read_text(encoding='utf-8-sig').splitlines():
            if line.startswith('```'):
                flush()
                if in_code:
                    flow.append(Preformatted('\n'.join(code), code_style,
                                             maxLineLength=84, splitChars=' '))
                    code.clear()
                in_code = not in_code
                continue
            if in_code:
                code.append(line)
                continue
            if not line.strip():
                flush()
            elif line.startswith('# '):
                flush()
                flow.append(Paragraph(inline(line[2:]), styles['TitleGuide']))
            elif line.startswith('## '):
                flush()
                flow.append(Paragraph(inline(line[3:]), styles['HeadingGuide']))
            elif line.startswith('> '):
                paragraph.append(line[2:])
            else:
                paragraph.append(line)
        flush()

    render(source)
    if append:
        flow.append(PageBreak())
        render(append)
    output.parent.mkdir(parents=True, exist_ok=True)
    def footer(canvas, doc):
        canvas.saveState()
        canvas.setStrokeColor(colors.HexColor('#ccd7df'))
        canvas.line(18*mm, 17*mm, 192*mm, 17*mm)
        canvas.setFont(font, 8)
        canvas.setFillColor(colors.HexColor('#526675'))
        canvas.drawString(18*mm, 12*mm, 'Fermata Samsung | Panduan komunitas | 26 Oktober 2026')
        canvas.drawRightString(192*mm, 12*mm, str(doc.page))
        canvas.restoreState()
    doc = SimpleDocTemplate(str(output), pagesize=A4, rightMargin=18*mm,
                            leftMargin=18*mm, topMargin=18*mm, bottomMargin=24*mm,
                            title=source.stem, author='Fermata Samsung community setup')
    doc.build(flow, onFirstPage=footer, onLaterPages=footer)
    print(output)

if __name__ == '__main__':
    parser = argparse.ArgumentParser()
    parser.add_argument('--source', type=Path, default=ROOT / 'docs/INSTALASI-AGENT.id.md')
    parser.add_argument('--output', type=Path, default=ROOT / 'docs/INSTALASI-AGENT.id.pdf')
    parser.add_argument('--append', type=Path)
    args = parser.parse_args()
    appendix = args.append
    if appendix is None and args.source == ROOT / 'docs/INSTALASI-AGENT.id.md':
        appendix = ROOT / 'prompts/STEPS.id.md'
    build(args.source, args.output, appendix)
