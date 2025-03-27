import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:ModulexNote/PageParch1/ImageNoticePage/parts/NoticeSidemanu.dart';

class DetailPage extends StatefulWidget {
  final dynamic notice;

  DetailPage(this.notice);

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> data =
    widget.notice is Map<String, dynamic>
        ? widget.notice
        : (widget.notice.data() as Map<String, dynamic>);

    final String title = data["title"] ?? "";
    final String content = data["content"] ?? "";
    final String pdfUrl = data["pdfUrl"] ?? "";
    final List<String> imageUrls =
    data.containsKey("imageUrls") ? List<String>.from(data["imageUrls"]) : [];


    double screenWidth = MediaQuery.of(context).size.width;
    bool showSideMenu = screenWidth > 600;


    return Scaffold(
      backgroundColor: Colors.white,
      appBar: showSideMenu
          ? null
          : AppBar(
        backgroundColor: Colors.white,
        title: Container(height: 40, child: Image.asset('poto/logo3.png')),
      ),
      body: Row(
        children: [
          if (showSideMenu)
            NoticeSideMenu(
              parentContext: context,
              noticeData: widget.notice,
            ),
          Expanded(
            flex: 3,
            child: ListView(
                padding: EdgeInsets.all(16),
                children: [
                  /// 제목
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      title,
                      style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(height: 12),

                  /// 본문 설명
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      content,
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  SizedBox(height: 20),


                  /// 이미지 리스트
                  if (imageUrls.isNotEmpty) Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: _buildImageList(context, imageUrls),
                  ),

                  _buildConnectSection(),
                  _LightingData()
                ],
              ),
          ),
        ],
      ),
    );
  }

  /// 이미지 슬라이더
  Widget _buildImageList(BuildContext context, List<String> imageUrls) {
    return Padding(
      padding: EdgeInsets.all(50),
      child: Center(
        child: CarouselSlider(
          options: CarouselOptions(
            height: 500,
            autoPlay: true,
            enlargeCenterPage: true,
            viewportFraction: 0.75,
            autoPlayInterval: Duration(seconds: 5),
            autoPlayAnimationDuration: Duration(milliseconds: 800),
            enableInfiniteScroll: true,
            scrollPhysics: BouncingScrollPhysics(),
          ),
          items: imageUrls.map((imageUrl) {
            return Builder(
              builder: (BuildContext context) {
                return Container(
                  margin: EdgeInsets.symmetric(horizontal: 5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 5,
                        spreadRadius: 2,
                        offset: Offset(4, 4),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Image.network(
                      imageUrl,
                      width: MediaQuery
                          .of(context)
                          .size
                          .width * 0.8,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Image.asset(
                            'assets/default.jpg', fit: BoxFit.cover);
                      },
                    ),
                  ),
                );
              },
            );
          }).toList(),
        ),
      ),
    );
  }


  /// 연결 블록 강조 디자인
  Widget _buildConnectSection() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 24),
      decoration: BoxDecoration(
        color: Color(0xff003f62), // 연한 빨간색 배경
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(50),
          topRight: Radius.circular(0),
          bottomLeft: Radius.circular(0),
          bottomRight: Radius.circular(50),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: _buildconnect(),
      ),
    );
  }

  Widget _buildconnect() {
    // 1. 문단 자동 나누기 함수 (일본어 마침표 기준)
    String autoParagraph(String text) {
      return text.replaceAll('。', '。\n\n');
    }

    // 2. 실제 내용
    final String contentText = '''広大な敷地に広がる麻布台ヒルズの中核を担う「麻布台ヒルズ 森JPタワー」の33〜34階に位置し、窓からは東京ベイエリアや間近にそびえる東京タワーを望む「Hills House」様にModuleX®をご採用いただきました。

オフィスビル入居企業とその従業員が利用できる施設で、街全体をワークプレイスとして使う拠点となり、
・三國清三が監修するグランビストロ「Dining 33」
・会員専用エリア「Members Lounge」
・多目的に使える大型ダイニング「Sky Room」
の3つのエリアで構成された交流・学び・憩いの場です。

自然光と人工光のバランスを考慮した照明設計技法「ライティングナチュラライゼーション®︎」により、最適な照明環境を実現しました。

また「視野角内ライティングモデュレーション®」と「タイムシークエンスデザイン®」を活用し、時間帯・用途に応じて光の在り方を変化させる設計が行われています。

照明器具はグレアコントロールされたダウンライトを使用し、夜間でもガラスへの映り込みがなく、昼間と同様にクリアな景観を楽しめます。''';

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
      ),
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// 제목
          Text(
            "新たな時代を創るフレキシブルな照明のあり方",
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 24),

          /// 본문
          Text(
            autoParagraph(contentText),
            style: TextStyle(
              fontSize: 16,
              height: 1.9,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget image(String? path) {
    if (path == null || path == "null" || path.trim().isEmpty) {
      return Container(
        color: Colors.grey[300],
        height: 150,
        child: Icon(Icons.image_not_supported, size: 64, color: Colors.grey),
      );
    }

    return Image.asset(
      'assets/images/$path.png',
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) {
        return Icon(Icons.broken_image, size: 64, color: Colors.red);
      },
    );
  }


  Widget _LightingData() {
    String autoParagraph(String text) {
      return text.replaceAll('。', '。\n\n');
    }
    final lightingItems = [
      {
        "text": "朝日がゆっくりと昇る時間になると、室内の照明が自動的に優しくオフになり、それと同時に遮光カーテンが静かに開き始めます。天候センサーと連動したシステムが外の明るさを感知し、最も心地よいタイミングで室内に自然光を取り込むことで、まるで自然と一体になったかのような朝を演出します。アラーム音に頼らず、光によって目覚めるこの仕組みは、ストレスの少ない目覚めを促進し、睡眠の質を高めると同時に、一日をよりポジティブな気持ちで始める手助けとなります。また、遮光レベルや開閉スピードはアプリで細かく設定可能で、個々の生活スタイルや好みに合わせたパーソナライズが可能です。",
        "image": null
      },
      {
        "text": "部屋の照明は、シーンごとに異なる明るさや色温度を細かく設定できるようになっており、読書、仕事、リラックス、映画鑑賞など、さまざまな生活シーンに応じた光の演出が可能です。例えば、集中力を高めたいときには白色の強めな光に、逆にリラックスしたいときには暖色系の柔らかい光に自動で切り替わります。また、スマートフォンや音声アシスタントと連携しており、「おやすみモード」と言うだけで照明が徐々に暗くなるなど、ユーザーの声やスケジュールに合わせて自律的に反応します。このような照明制御により、光のストレスを軽減し、心と身体のバランスを整える空間を提供します。",
        "image": null
      },
      {
        "text": "夜間には人感センサーが常に周囲の動きを監視しており、人が通ったことを検知すると、瞬時に柔らかい光で照明が点灯します。これにより、真っ暗な中でつまずいたり、スイッチを探したりする手間が省け、特に高齢者や子供のいる家庭では安心感が高まります。さらに、一定時間人の動きがない場合には自動で照明がオフになるため、消し忘れによる無駄な電力消費を防ぎ、省エネにも貢献します。このシステムは廊下、玄関、トイレなど、夜間に頻繁に利用される場所に特化して最適化されており、暗くても安心して移動できる住環境を実現します。",
        "image": null
      },
    ];


    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: lightingItems.length,
      itemBuilder: (context, index) {
        final item = lightingItems[index];
        final isReversed = index % 2 == 1;
        final isGreenBackground = index % 2 == 1;

        final imageWidget = Expanded(
          flex: 1,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: ConstrainedBox(
                constraints: BoxConstraints(maxHeight: 200),
                child: image(item['image']),
              ),
            ),
          ),
        );

        final textWidget = Expanded(
          flex: 2,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              autoParagraph(item['text'] ?? ''),
              style: TextStyle(fontSize: 16,color: isGreenBackground ? Colors.white : Colors.black),
            ),
          ),
        );

        return Container(
          decoration: BoxDecoration(
            color: isGreenBackground ? Color(0xff003f62) : Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(40),
              bottomRight: Radius.circular(40),
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: isReversed
                ? [imageWidget, textWidget]
                : [textWidget, imageWidget],
          ),
        );
      },
    );
  }
}
