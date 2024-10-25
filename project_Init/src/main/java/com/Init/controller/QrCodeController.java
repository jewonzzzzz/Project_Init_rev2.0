package com.Init.controller;

import java.io.ByteArrayOutputStream;
import java.io.IOException;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.google.zxing.BarcodeFormat;
import com.google.zxing.WriterException;
import com.google.zxing.client.j2se.MatrixToImageWriter;
import com.google.zxing.common.BitMatrix;
import com.google.zxing.qrcode.QRCodeWriter;

@RestController
public class QrCodeController {


    @GetMapping("/getQR")
    public ResponseEntity<byte[]> createQr(@RequestParam String emp_id) {
        String mainUrl = "http://localhost:8088/Attendance/attendanceMain";
        String qrCodeUrl = mainUrl + "?emp_id=" + emp_id;

        qrCodeWriter qrCodeWriter = new QRCodeWriter();
        try {
            // QR 肄붾뱶 �깮�꽦
            BitMatrix bitMatrix = qrCodeWriter.encode(qrCodeUrl, BarcodeFormat.QR_CODE, 200, 200);
            

            // �씠誘몄�瑜� 諛붿씠�듃 諛곗뿴濡� 蹂��솚
            ByteArrayOutputStream baos = new ByteArrayOutputStream();
            MatrixToImageWriter.writeToStream(bitMatrix, "PNG", baos);

            // ResponseEntity濡� 諛붿씠�듃 諛곗뿴 諛섑솚
            return ResponseEntity.ok()
                    .contentType(MediaType.IMAGE_PNG)
                    .body(baos.toByteArray());
        } catch (WriterException e) {
            // QR 肄붾뱶 �깮�꽦 �삤瑜� 泥섎━
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body("QR 肄붾뱶 �깮�꽦�뿉 �떎�뙣�뻽�뒿�땲�떎.".getBytes());
        } catch (IOException e) {
            // �씠誘몄� 蹂��솚 �삤瑜� 泥섎━
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body("�씠誘몄� 蹂��솚�뿉 �떎�뙣�뻽�뒿�땲�떎.".getBytes());
        }
    }
}

