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
	        String mainUrl = "http://c6d2406t2.itwillbs.com/Attendance/attendanceMain";
	        String qrCodeUrl = mainUrl + "?emp_id=" + emp_id;

	        QRCodeWriter qrCodeWriter = new QRCodeWriter();
	        try {
	            // QR 코드 생성
	            BitMatrix bitMatrix = qrCodeWriter.encode(qrCodeUrl, BarcodeFormat.QR_CODE, 200, 200);

	            // 이미지를 바이트 배열로 변환
	            ByteArrayOutputStream baos = new ByteArrayOutputStream();
	            MatrixToImageWriter.writeToStream(bitMatrix, "PNG", baos);

	            // ResponseEntity로 바이트 배열 반환
	            return ResponseEntity.ok()
	                    .contentType(MediaType.IMAGE_PNG)
	                    .body(baos.toByteArray());
	        } catch (WriterException e) {
	            // QR 코드 생성 오류 처리
	            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
	                    .body("QR 코드 생성에 실패하였습니다.".getBytes());
	        } catch (IOException e) {
	            // 이미지 변환 오류 처리
	            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
	                    .body("이미지 변환에 실패하였습니다.".getBytes());
	        }
	    }
	}

