// ・メンバー名を訂正
// ・引き分けは0.5勝扱いにする

// 結果入力画面
// ・一度対戦した相手はもう一度当たらないようにすること⇨avoidDuplication
// ・奇数人の場合はいったん考慮しないこととする

import 'dart:io';

int gameNum = 0;
int memberNum = 0;
int matchNum = 0;
int matchCount = 0;
List members = []; //['選手名', 合計獲得石数, [対局ごとの石数], 勝利数, 入力済み試合数]の形式で入力
List<List<String>> matchingHistories = [];

void main() {
  settings();
  for (var i = 0; i < gameNum; i++) {
    matchings();
    inputResult();
    printResult();
    print(matchingHistories);
    avoidDuplication();
  }
  print('最終結果');
  members.asMap().forEach((ranking, member) {
    print(
        '${ranking + 1}位: ${member[3]}勝 ${member[0]} ${member[1]}石 (${member[2]}))');
  });
}

void settings() {
  print('試合数を入力してください');
  final input0 = stdin.readLineSync();
  print('参加者数を入力してください');
  final input1 = stdin.readLineSync();
  if (input0 != null && input1 != null) {
    gameNum = int.parse(input0);
    memberNum = int.parse(input1);
    matchNum = (memberNum / 2).floor();
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
  matchCount += 1;
  print('${matchCount}回戦');
  for (var i = 0; i < matchNum; i++) {
    matchingHistories.add([(members[i * 2][0]), (members[i * 2 + 1][0])]);
    print('table${i + 1}: ${members[i * 2][0]} vs ${members[i * 2 + 1][0]}');
  }
}

void avoidDuplication() {
  List temporaryMembers = members;
  for (var i = 0; i < matchNum; i++) {
    matchingHistories.forEach((element) {
      ///組み合わせがmatchingHistoriesに存在するかチェック
      if (element.contains(temporaryMembers[i * 2][0]) &&
          element.contains(temporaryMembers[i * 2 + 1][0])) {
        var before = -1;
        var after = 1;
        List<Object> playerA;
        List<Object> playerB;
        print('重複あり');
        while (true) {
          if (i > 0) {
            playerA = members[i * 2 + before];
            playerB = members[i * 2];
            temporaryMembers[i * 2] = playerA;
            temporaryMembers[i * 2 + before] = playerB;
            if (checkDuplication(temporaryMembers)) {
              members = temporaryMembers;
              break;
            }
            temporaryMembers = members;
          }
          if (i < matchNum) {
            playerA = members[i * 2 + 1 + after];
            playerB = members[i * 2 + 1];
            temporaryMembers[i * 2 + 1] = playerA;
            temporaryMembers[i * 2 + 1 + after] = playerB;
            print('にばんめ');
            print(temporaryMembers);
            if (checkDuplication(temporaryMembers)) {
              members = temporaryMembers;
              break;
            }
            temporaryMembers = members;
          }
          if (i > 1) {
            playerA = members[i * 2 + after];
            playerB = members[i * 2];
            temporaryMembers[i * 2] = playerA;
            temporaryMembers[i * 2 + after] = playerB;
            after++;
            print('さんばんめ');
            print(temporaryMembers);
            if (checkDuplication(temporaryMembers)) {
              members = temporaryMembers;
              break;
            }
            temporaryMembers = members;
          }
          if (i < matchNum + before) {
            playerA = members[i * 2 + 1 + before];
            playerB = members[i * 2 + 1];
            temporaryMembers[i * 2 + 1] = playerA;
            temporaryMembers[i * 2 + 1 + before] = playerB;
            before--;
            print('よんばんめ');
            print(temporaryMembers);
            if (checkDuplication(temporaryMembers)) {
              members = temporaryMembers;
              break;
            }
            temporaryMembers = members;
          }
        }
      }
    });
  }
}

bool checkDuplication(list) {
  if (list == null) return false;
  //matchingHistoriesに更新後の組み合わせがあるかチェックする
  bool result = false;
  for (var i = 0; i < matchNum; i++) {
    matchingHistories.forEach((element) {
      if (element.contains(list[i * 2][0]) &&
          element.contains(list[i * 2 + 1][0])) {
        print('重複まだあるよ');
        result = false;
      } else {
        result = true;
      }
    });
  }
  return result;
}

void inputResult() {
  for (var i = 0; i < matchNum; i++) {
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
  for (var i = 0; i < matchNum; i++) {
    print('table${i + 1}: ${members[i * 2][0]} vs ${members[i * 2 + 1][0]}');
    print(
        '${members[i * 2][2][matchCount - 1]} 対 ${members[i * 2 + 1][2][matchCount - 1]}');
  }
}

void printResult() {
  while (0 == 0) {
    print('f: 入力したデータを修正  c: 入力したデータを確認  e: 入力を終了する');
    var input5 = stdin.readLineSync();
    if (input5 != null) {
      var guidance = input5;
      if (guidance == 'f') {
        print('fix');
      } else if (guidance == 'c') {
        checkResult();
      } else if (guidance == 'e') {
        print('入力を終了しました');
        break;
      }
    }
  }
  //勝利数、石数の順でソートできるようにすること
  members.sort((a, b) => b[1].compareTo(a[1]));
  members.asMap().forEach((ranking, member) {
    print('${ranking + 1}位: ${member[0]} ${member[1]}石');
  });
}

void checkResult() {
  for (var i = 0; i < matchNum; i++) {
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
