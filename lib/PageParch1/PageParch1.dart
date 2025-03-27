import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';



Widget NewsCard(Function()? onTap, QueryDocumentSnapshot doc) {
  String Title = "title";
  String day = "day";
  String content = "content";
  String Point = "Point";
  String Name = "Name";
  String Oner = "Oner";



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
          border: Border.all(color: Colors.black)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 220,
                    child: Text(
                      doc[Title],
                      style: TextStyle(fontSize: 24),
                      maxLines: 1,
                    ),
                  ),
                  Container(width: 200,height: 2,color: Color(0xFF013B5E)),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.room,size: 16,),
                      Text(
                        doc[Point],
                        style: TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.receipt_long,size: 16,),
                      Container(
                        width: 220,
                        child: Text(
                          doc[content],
                          style: TextStyle(fontSize: 14),
                          maxLines: 1,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                doc[Name],
                style: TextStyle(fontSize: 15),
              ),
              Container(
                width: 80,
                  child: Text(
                    doc[day],
                    style: TextStyle(fontSize: 10),
                    textAlign: TextAlign.end,
                    maxLines: 1,
                  ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
