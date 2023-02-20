import 'dart:io';

import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
import 'package:realtime_chat/models/prescripcion.dart';
import 'package:realtime_chat/models/receta.dart';
import 'package:realtime_chat/services/prescripcion_service.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';

Future<void> createPDF(String id, String paciente, DateTime fecha) async {
  // Create a new PDF document.
  final PdfDocument document = PdfDocument();
  // Add a new page to the document.
  final PdfPage page = document.pages.add();
  //Get page client size
  final Size pageSize = page.getClientSize();
  //Draw rectangle
  page.graphics.drawRectangle(
      bounds: Rect.fromLTWH(0, 0, pageSize.width, pageSize.height),
      pen: PdfPen(PdfColor(100, 100, 100)));
  //Generate PDF grid.
  final prescripcionService = new PrescripcionsService();
  List<PrescripcionElement> receta = [];
  receta = await prescripcionService.getPrescripcion(id);
  final PdfGrid grid = getGrid(receta, page);
  //Draw the header section by creating text element
  final PdfLayoutResult result =
      drawHeader(page, pageSize, grid, paciente, fecha);
  // //Draw grid
  drawGrid(page, grid, result);
  //Add invoice footer
  drawFooter(page, pageSize);
  // // Save the document.
  final List<int> bytes = await document.save();
  // Dispose the document.
  document.dispose();

  final String path = (await getExternalStorageDirectory())!.path;
  final String fileName = '$path/Receta $paciente ${fecha.toString().substring(0, 10)}.pdf';
  final File file = File(fileName);
  await file.writeAsBytes(bytes, flush: true);
  OpenFile.open(fileName);

  // // Save the document.
  // File(fileName).writeAsBytes(await document.save());
  // // Dispose the document.
  // document.dispose();
}

PdfGrid getGrid(List<PrescripcionElement> receta, PdfPage page) {
  // Create a PDF grid class to add tables.
  final PdfGrid grid = PdfGrid();
  // Specify the grid column count.
  grid.columns.add(count: 4);
  grid.columns[0].width = 130;
  grid.columns[1].width = 230;
  grid.columns[2].width = 50;
  // grid.columns[3].width = ;
  // Add a grid header row.
  final PdfGridRow headerRow = grid.headers.add(1)[0];
  headerRow.cells[0].value = '#';
  headerRow.cells[0].stringFormat.alignment = PdfTextAlignment.center;
  headerRow.cells[1].value = 'Producto';
  headerRow.cells[1].stringFormat.alignment = PdfTextAlignment.center;
  headerRow.cells[2].value = 'Dosis';
  headerRow.cells[2].stringFormat.alignment = PdfTextAlignment.center;
  headerRow.cells[3].value = 'Instrucción';
  headerRow.cells[3].stringFormat.alignment = PdfTextAlignment.center;
  // Set header font.
  headerRow.style.font =
      PdfStandardFont(PdfFontFamily.helvetica, 10, style: PdfFontStyle.bold);
  // Add rows to the grid.
  PdfGridRow row = grid.rows.add();
  List.generate(receta.length, (index) {
    PrescripcionElement prescripcion = receta[index];
    row.cells[0].value = prescripcion.id;
    row.cells[1].value = prescripcion.producto.nombre;
    row.cells[2].value = prescripcion.dosis.toString();
    row.cells[3].value = prescripcion.instruccion;
    if (index != receta.length - 1) {
      row = grid.rows.add();
    }
  });
  // Set grid format.
  grid.style.cellPadding = PdfPaddings(left: 5, top: 5);
  return grid;
}

//Draws the invoice header
PdfLayoutResult drawHeader(PdfPage page, Size pageSize, PdfGrid grid,
    String paciente, DateTime fecha) {
  final PdfFont contentFont = PdfStandardFont(PdfFontFamily.helvetica, 9);
  final PdfFont contentFont2 = PdfStandardFont(PdfFontFamily.helvetica, 20);
  //Create data foramt and convert it to text.
  final DateFormat format = DateFormat.yMd();
  final String titulo = 'Receta Electrónica';
  final String invoiceNumber = 'Fecha: ${format.format(fecha)}';
  final Size contentSize = contentFont.measureString(invoiceNumber);
  // ignore: leading_newlines_in_multiline_strings
  final String address = '''Dr: Xxxxxx Xxxxxx, 
      \r\nPaciente: $paciente''';

  PdfTextElement(text: invoiceNumber, font: contentFont).draw(
      page: page,
      bounds: Rect.fromLTWH(pageSize.width - (contentSize.width + 30), 85,
          contentSize.width + 30, pageSize.height - 120));

  PdfTextElement(text: titulo, font: contentFont2).draw(
      page: page,
      bounds: Rect.fromLTWH(pageSize.width - (contentSize.width + 270), 40,
          contentSize.width + 150, pageSize.height - 120));

  return PdfTextElement(text: address, font: contentFont).draw(
      page: page,
      bounds: Rect.fromLTWH(30, 85, pageSize.width - (contentSize.width + 30),
          pageSize.height - 120))!;
}

//Draws the grid
void drawGrid(PdfPage page, PdfGrid grid, PdfLayoutResult result) {
  //Draw the PDF grid and get the result.
  result = grid.draw(
      page: page, bounds: Rect.fromLTWH(0, result.bounds.bottom + 40, 0, 0))!;
}

//Draw the invoice footer data.
void drawFooter(PdfPage page, Size pageSize) {
  final PdfPen linePen =
      PdfPen(PdfColor(100, 100, 100), dashStyle: PdfDashStyle.custom);
  linePen.dashPattern = <double>[3, 3];
  //Draw line
  page.graphics.drawLine(linePen, Offset(0, pageSize.height - 60),
      Offset(pageSize.width, pageSize.height - 60));

  const String footerContent =
      // ignore: leading_newlines_in_multiline_strings
      '''Bolivia/Santa Cruz\r\nSanta Cruz de la Sierra\r\n1er anillo/Av Centenario/Pasillo Barbery''';

  //Added 30 as a margin for the layout
  page.graphics.drawString(
      footerContent, PdfStandardFont(PdfFontFamily.helvetica, 9),
      format: PdfStringFormat(alignment: PdfTextAlignment.right),
      bounds: Rect.fromLTWH(pageSize.width - 30, pageSize.height - 50, 0, 0));
}
