import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

/// 🔹 공지 카드 위젯
Widget NewsCard(Function()? onTap, QueryDocumentSnapshot doc) {
  // 🔒 필드 키
  String Title = "title";
  String day = "day";
  String content = "content";
  String Point = "Point";
  String Name = "Name";
  String Oner = "Oner";

  // ✅ 안전하게 필드 값 추출 (toString 처리로 예외 방지)
  String titleStr = doc[Title]?.toString() ?? "タイトルなし";
  String pointStr = doc[Point]?.toString() ?? "場所なし";
  String contentStr = doc[content]?.toString() ?? "内容なし";
  String nameStr = doc[Name]?.toString() ?? "担当者なし";
  String dayStr = doc[day]?.toString() ?? "";

  return InkWell(
    onTap: onTap,
    child: Container(
      height: 100,
      width: double.infinity,
      padding: EdgeInsets.all(8.0),
      margin: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: Colors.black),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          /// 🔹 왼쪽 (제목 + 장소 + 내용)
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// 제목
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 220,
                    child: Text(
                      titleStr,
                      style: TextStyle(fontSize: 24),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Container(width: 200, height: 2, color: Color(0xFF013B5E)),
                ],
              ),
              /// 장소 + 내용
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.room, size: 16),
                      SizedBox(width: 4),
                      Text(
                        pointStr,
                        style: TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.receipt_long, size: 16),
                      SizedBox(width: 4),
                      Container(
                        width: 220,
                        child: Text(
                          contentStr,
                          style: TextStyle(fontSize: 14),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          /// 🔹 오른쪽 (이름 + 날짜)
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                nameStr,
                style: TextStyle(fontSize: 15),
              ),
              Container(
                width: 80,
                child: Text(
                  dayStr,
                  style: TextStyle(fontSize: 10),
                  textAlign: TextAlign.end,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
