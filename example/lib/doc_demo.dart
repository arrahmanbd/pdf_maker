import 'package:flutter/material.dart';
import 'package:pdf_maker/pdf_maker.dart';

class MultiLanguagePDF extends BlankPage {
  const MultiLanguagePDF({super.key});

  @override
  Widget createPageContent(BuildContext context) {
    return Container(
      color: Colors.white,
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'চিরকুট',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24,
                fontFamily: 'BanglaTest'),
          ),
          SizedBox(height: 10.0),
          Text(
            "অশ্রুকণ্যা,\nআজকাল খুব আগ্রাসী হতে ইচ্ছে করে, খানিক বাউণ্ডুলে! খানিকটা হ্যাংলাও! সব ছেড়েছুড়ে দিয়ে নির্লজ্জের মতোন তোমার কথাই ভাবি দিনরাত্তির। তবু সেই দুটো চোখ ভুলি না, একরত্তিতো একখানা ছবি! তার অস্তিত্ব এতো বিশালাকায়!\nকবিতার খাতা, গল্পের পাতা, পড়ার টেবিল, বইয়ের তাক; সবটা জুড়েই এখন তোমার অনিবার্য অস্তিত্ব চরমভাবে দৃশ্যমান। তোমাকে সরাতে পারি গায়ের জোরে এমন শক্তি সত্যিই আমার নেই।\nভাবতেই কষ্ট হয়,নির্মল বিকেলের নির্মলতায় তোমাকে দেখা হবে না। রাতের শেষ প্রহরে ঘুমের ঘোরে তোমার নিষ্পাপ মুখ খানা দেখা হবে না।",
            style: TextStyle(fontFamily: 'BanglaTest'),
          ),
          SizedBox(height: 10.0),
          Text(
              "Tearful girl,\nNowadays I feel like being very aggressive, somewhat vagrant! A bit greedy too! I shamelessly think of you day and night, abandoning everything else.\n Yet, I don't forget those two eyes, such a tiny image! Its presence is so immense!\nPoetry notebooks, story pages, reading tables, bookshelves; your inevitable existence is now intensely visible everywhere. I truly don't have the strength to forcibly remove you.",
              style: TextStyle(fontFamily: 'EnglishTest')),
          SizedBox(height: 10.0),
          Text(
              '泪眼女孩，\n最近我很想变得非常咄咄逼人，有点像个流浪者！也有点贪婪！我无耻地日夜想你，抛弃一切。然而，我不会忘记那双眼睛，那样一张小小的照片！它的存在是如此巨大！\n诗歌笔记本，故事页面，阅读桌，书架；你的必然存在现在无处不在，极为显眼。我真的没有力量用蛮力把你移走。'),
          SizedBox(height: 10.0),
          Text(
              "Tränenmädchen,\nIn letzter Zeit habe ich das Bedürfnis, sehr aggressiv zu sein, ein bisschen Vagabundin! Ein bisschen gierig auch! Ich denke unverschämt Tag und Nacht an dich und lasse alles andere zurück. Doch ich vergesse diese zwei Augen nicht, so ein kleines Bild! Seine Präsenz ist so immens!\nPoesiehefte, Geschichtenseiten, Lesetische, Bücherregale; deine unvermeidliche Existenz ist jetzt überall intensiv sichtbar. Ich habe wirklich nicht die Kraft, dich gewaltsam zu entfernen."),
          SizedBox(height: 10.0),
          Text(
              'अश्रुपूर्ण लड़की,\nआजकल मुझे बहुत आक्रामक बनने का मन करता है, थोड़ा आवारा भी! थोड़ा लालची भी! मैं बेशर्मी से दिन-रात तुम्हारे बारे में ही सोचता हूं, सब कुछ छोड़कर। फिर भी, मैं उन दो आंखों को नहीं भूलता, इतनी छोटी सी तस्वीर! उसका अस्तित्व इतना विशाल है!\nकविता की नोटबुक, कहानियों के पन्ने, पढ़ने की मेज, किताबों की अलमारी; तुम्हारा अपरिहार्य अस्तित्व अब हर जगह गहराई से दिखाई दे रहा है। मुझे सच में इतनी ताकत नहीं है कि तुम्हें जबरदस्ती हटा सकूं।',
              style: TextStyle(fontFamily: 'HindiTest'))
        ],
      ),
    );
  }
}
