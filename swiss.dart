// 	- メンバーナンバーをつける(これで管理する)
// ・メンバー名を訂正
// ・メンバー入力後、マッチング相手をランダムで決める
// ・石数が多かった順番にランキングをつける
// ・引き分けは0.5勝扱いにする

// 結果入力画面
// ・テーブル番号から結果を入力する
// 	- 対戦相手も自動入力されるとなお良い
//    - 一回戦、2回戦ごとに配列で管理するのはあり。
// 		- 途中で指定されたキーを入力すると入力途中経過が見れる
//         -
// ・一度対戦した相手はもう一度当たらないようにすること
// ・奇数人の場合はいったん考慮しないこととする

// 終わったら次の対戦相手が表示される。

// 以上を規定の試合数くりかえす

// 全て終わったら試合終了し、自動で結果表示

// 必要class
// ・対戦数管理
// ・選手名入力
// ・選手名修正
// ・入力上方修正
// ・対局履歴
// ・対局結果入力と保存　保存が終われば表示

// class外で管理
// ・メンバー数、名前、対局履歴、マッチング
// ・

import 'dart:io';

int gameNum = 0;
int memberNum = 0;
int matchCount = 0;
List members = []; //['選手名', 合計獲得石数, [対局ごとの石数], 勝利数, 入力済み試合数]の形式で入力
List<List<String>> matchingHistories = [];

void main() {
  settings();
  for (var i = 0; i < gameNum; i++) {
    matchings();
    printResult();
  }
  print('最終結果');
  members.asMap().forEach((ranking, member) {
    print(
        '${ranking + 1}位: ${member[3]}勝 ${member[0]} ${member[1]}石 (${member[2]}))');
  });
  print(matchingHistories);
}

void settings() {
  print('試合数を入力してください');
  final input0 = stdin.readLineSync();
  print('参加者数を入力してください');
  final input1 = stdin.readLineSync();
  if (input0 != null && input1 != null) {
    gameNum = int.parse(input0);
    memberNum = int.parse(input1);
  }
  print('参加者名を入力してください。');
  for (var i = 0; i < memberNum; i++) {
    print('${i + 1}人目');
    var input2 = stdin.readLineSync();
    if (input2 != null) {
      members.add([input2, 0, [], 0, 0]);
    }
  }
  members.shuffle();
}

void correctName() {
  //のちに実装
  //間違った参加者名を入力した場合、削除修正できる
}

void matchings() {
  print('対戦一覧表');
  for (var i = 0; i < memberNum / 2; i++) {
    matchingHistories.add([(members[i * 2][0]), (members[i * 2 + 1][0])]);
    print('table${i + 1}: ${members[i * 2][0]} vs ${members[i * 2 + 1][0]}');
  }
  matchCount += 1;
}

void avoidDuplication() {
  //のちに実装
  //重複したマッチを回避する
  //matchingHistoriesにて対局履歴を保存して、重複があった場合並び替えるようにする
  if (matchCount * )
}

// sが2回入力されたたれたときの対処を考えること
void printResult() {
  while (0 == 0) {
    print('s: 入力開始  f: 入力したデータを修正 e: 入力を終了する');
    var input5 = stdin.readLineSync();
    if (input5 != null) {
      var guidance = input5;
      if (guidance == 's') {
        inputResult();
      } else if (guidance == 'f') {
        print('fix');
      } else if (guidance == 'e') {
        print('入力を終了しました');
        break;
      }
    }
  }
  members.sort((a, b) => b[1].compareTo(a[1]));
  members.asMap().forEach((ranking, member) {
    print('${ranking + 1}位: ${member[0]} ${member[1]}石');
  });
}

void inputResult() {
  for (var i = 0; i < memberNum / 2; i++) {
    print('結果を入力する試合のtable番号を入力してください');
    var input3 = stdin.readLineSync();
    if (input3 != null) {
      var table = int.parse(input3) - 1;
      var playerA = members[table * 2];
      var playerB = members[table * 2 + 1];
      print('table${table + 1}: ${playerA[0]} vs ${playerB[0]}');

      print('${playerA[0]}の石数を入力してください');
      var input4 = stdin.readLineSync();
      if (input4 != null) {
        var stones = int.parse(input4);
        playerA[1] += stones;
        playerB[1] += 64 - stones;
        playerA[2].add(stones);
        playerB[2].add(64 - stones);
        if (stones > 33) {
          playerA[3] += 1;
        } else if (stones == 32) {
          playerA[3] += 0.5;
          playerB[3] += 0.5;
        } else {
          playerB[3] += 1;
        }
        playerA[4] += 1;
        playerB[4] += 1;
      }
    }
  }
  for (var i = 0; i < memberNum / 2; i++) {
    print('table${i + 1}: ${members[i * 2][0]} vs ${members[i * 2 + 1][0]}');
    print(
        '${members[i * 2][2][matchCount - 1]} 対 ${members[i * 2 + 1][2][matchCount - 1]}');
  }
}

void checkResult() {
  for (var i = 0; i < memberNum / 2; i++) {
    print('table${i + 1}: ${members[i * 2][0]} vs ${members[i * 2 + 1][0]}');
    print(
        '${members[i * 2][2][matchCount - 1]} 対 ${members[i * 2 + 1][2][matchCount - 1]}');
  }
}

void fixResult() {
  //のちに実装
  //入力結果を修正できる
  //forEachなどは使わずに、ひとつずつ変更できるように実装
}
