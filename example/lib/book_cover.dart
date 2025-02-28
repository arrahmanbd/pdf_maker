import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pdf_maker/pdf_maker.dart';

import 'painted.dart';

// Page 1
class BookCover extends BlankPage {
  const BookCover({super.key});

  @override
  Widget createPageContent(BuildContext context) {
    return Container(
      width: 400,
      height: 550,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        image: const DecorationImage(
          image: NetworkImage(
              "https://images.pexels.com/photos/1004014/pexels-photo-1004014.jpeg"),
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            top: 50,
            left: 20,
            right: 20,
            child: Text(
              "The Flutter Journey",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                shadows: [
                  Shadow(blurRadius: 5, color: Colors.black.withOpacity(0.5))
                ],
              ),
            ),
          ),
          const Positioned(
            top: 100,
            left: 20,
            right: 20,
            child: Text(
              "A Demo of PDF Maker",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                color: Colors.white70,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
          const Positioned(
            bottom: 40,
            left: 20,
            right: 20,
            child: Text(
              "by AR",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Page 2
class Page2 extends BlankPage {
  const Page2({super.key});

  @override
  Widget createPageContent(BuildContext context) {
    return Container(
      color: const Color.fromARGB(230, 255, 255, 255),
      width: 400,
      height: 550,
      child: CustomPaint(
        painter: DottedBorderPainter(),
        child: Padding(
          padding: const EdgeInsets.only(top: 18.0),
          child: Stack(
            alignment: AlignmentDirectional.topCenter,
            children: [
              Text(
                "উৎসর্গ",
                style: GoogleFonts.lato(fontSize: 18),
              ),
              Center(
                child: SizedBox(
                  width: 300,
                  height: 300,
                  child: CustomPaint(
                    painter: MLetterCirclePainter(),
                  ),
                ),
              ),
              Positioned(
                bottom: 10,
                right: 20,
                child: Text(
                  'Page 1',
                  style: GoogleFonts.lato(
                      fontSize: 16, fontStyle: FontStyle.italic),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

//Page3
class Page3 extends BlankPage {
  const Page3({super.key});

  @override
  Widget createPageContent(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Text(
              'চিরকুট',
              style: GoogleFonts.hindSiliguri(
                  fontSize: 18, fontWeight: FontWeight.w800),
            ),
          ),
          const SizedBox(height: 30.0),
          Text(
            "অশ্রুকণ্যা,\nনিজেকে পুরনো ডাইরি কিংবা বইয়ের মত মনে হয়। কেমন বাজে এ অনুভুতি যখন মনে হয় কেউ তোমাকে ব্যবহার করে ছুড়ে ফেলে দিয়েছে‌।\nআজকাল খুব আগ্রাসী হতে ইচ্ছে করে, খানিক বাউণ্ডুলে! খানিকটা হ্যাংলাও! সব ছেড়েছুড়ে দিয়ে নির্লজ্জের মতোন তোমার কথাই ভাবি দিনরাত্তির। তবু সেই দুটো চোখ ভুলি না, একরত্তিতো একখানা ছবি! তার অস্তিত্ব এতো বিশালাকায়!\nকবিতার খাতা, গল্পের পাতা, পড়ার টেবিল, বইয়ের তাক; সবটা জুড়েই এখন তোমার অনিবার্য অস্তিত্ব চরমভাবে দৃশ্যমান। তোমাকে সরাতে পারি গায়ের জোরে এমন শক্তি সত্যিই আমার নেই।\nভাবতেই কষ্ট হয়,নির্মল বিকেলের নির্মলতায় তোমাকে দেখা হবে না। রাতের শেষ প্রহরে ঘুমের ঘোরে তোমার নিষ্পাপ মুখ খানা দেখা হবে না। ",
            style: GoogleFonts.hindSiliguri(
                fontSize: 16, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 10.0),
          Text(
              "Tearful girl,\nNowadays I feel like being very aggressive, somewhat vagrant! A bit greedy too! I shamelessly think of you day and night, abandoning everything else.\n Yet, I don't forget those two eyes, such a tiny image! Its presence is so immense!\nPoetry notebooks, story pages, reading tables, bookshelves; your inevitable existence is now intensely visible everywhere. I truly don't have the strength to forcibly remove you.\n诗歌笔记本，故事页面，阅读桌，书架；你的必然存在现在无处不在，极为显眼。我真的没有力量用蛮力把你移走。'",
              style:
                  GoogleFonts.asar(fontSize: 16, fontWeight: FontWeight.w500)),
          const SizedBox(height: 10.0),
          Text(
              'জানালা দিয়ে তাকিয়ে আছি বৃষ্টি ভেজা গাছের গুঁড়ির দিকে,'
              'শতবর্ষী গাছের গোড়ায় ছোট ছোট আগাছা। মঙ্গলের মত খটখটে শুকনো মাটিতে পড়ন্ত পানির ফোঁটার সাথে ভেজা মাটির যে ঘ্রাণ বের হয় তাতে জড়িয়ে থাকে শৈশবের সমস্ত স্মৃতি।'
              'আমার এ ছোট্ট জীবনে অবাক হওয়ার মত অনেক স্মৃতি আছে, তবুও এখন আমি কুয়াশামাখা ভোরে প্রেমিকার সাথে হেঁটে যাওয়া রাস্তার কথা বলব না।'
              'আমি বৃষ্টিভেজা দিনগুলোর কথা বলব।',
              style: GoogleFonts.hindSiliguri(
                  fontSize: 16, fontWeight: FontWeight.w500)),
          const SizedBox(height: 40.0),
          Center(
            child: Text('The End of the Story',
                style: GoogleFonts.acme(
                    fontSize: 18, fontWeight: FontWeight.w600)),
          ),
          const SizedBox(height: 10.0),
         
        ],
      ),
    );
  }
}
