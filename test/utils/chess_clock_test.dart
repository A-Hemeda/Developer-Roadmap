import 'package:chessclock/utils/chess_clock.dart';
import 'package:test/test.dart';

void main() {
  test("start", () {
    int nowMillis = 1000;
    final chessClock = ChessClock(
      getNowMillis: () => nowMillis,
      timeControlMillis: 0,
    );
    chessClock.start();
    nowMillis += 1000;
    expect(chessClock.getMillisElapsed(), equals(1000));
  });

  test("pause", () {
    int nowMillis = 1000;
    final chessClock = ChessClock(
      getNowMillis: () => nowMillis,
      timeControlMillis: 0,
    );
    chessClock.start();
    nowMillis += 1000;
    chessClock.pause();
    nowMillis += 1000;
    expect(chessClock.getMillisElapsed(), equals(1000));

    chessClock.start();
    nowMillis += 1000;
    expect(chessClock.getMillisElapsed(), equals(2000));
    chessClock.pause();

    nowMillis += 1000;
    expect(chessClock.getMillisElapsed(), equals(2000));
  });

  test("is time running", () {
    int nowMillis = 1000;
    final chessClock = ChessClock(
      getNowMillis: () => nowMillis,
      timeControlMillis: 1000,
    );
    expect(chessClock.isTicking(), equals(false));
    chessClock.start();
    expect(chessClock.isTicking(), equals(true));
    chessClock.pause();
    expect(chessClock.isTicking(), equals(false));
  });

  test("available time", () {
    int nowMillis = 1000;
    final chessClock = ChessClock(
      getNowMillis: () => nowMillis,
      timeControlMillis: 5000,
    );
    chessClock.start();
    expect(chessClock.getAvailableMillis(), equals(5000));
    nowMillis += 1000;
    expect(chessClock.getAvailableMillis(), equals(4000));
    chessClock.pause();
    nowMillis += 1000;
    expect(chessClock.getAvailableMillis(), equals(4000));
  });

  test("is time up", () {
    int nowMillis = 1000;
    final chessClock = ChessClock(
      getNowMillis: () => nowMillis,
      timeControlMillis: 5000,
    );
    chessClock.start();
    nowMillis += 5000;
    expect(chessClock.isTimeUp(), equals(true));
  });

  test("increments", () {
    int nowMillis = 1000;
    final chessClock = ChessClock(
      getNowMillis: () => nowMillis,
      timeControlMillis: 5000,
      incrementsMillis: 1000,
    );

    chessClock.start();
    nowMillis += 1000;
    chessClock.pause();

    chessClock.start();
    nowMillis += 1000;
    chessClock.pause();

    expect(chessClock.getAvailableMillis(), equals(5000 - 2000 + 2000));
  });

  test("paused first", () {
    int nowMillis = 1000;
    final chessClock = ChessClock(
      getNowMillis: () => nowMillis,
      timeControlMillis: 5000,
      incrementsMillis: 1000,
    );

    chessClock.pause();
    expect(chessClock.getMillisElapsed(), equals(0));
  });

  test("started multiple times", () {
    int nowMillis = 1000;
    final chessClock = ChessClock(
      getNowMillis: () => nowMillis,
      timeControlMillis: 5000,
      incrementsMillis: 1000,
    );

    chessClock.start();
    nowMillis += 1000;
    chessClock.start();
    nowMillis += 1000;
    expect(chessClock.getMillisElapsed(), equals(2000));
  });

  test("available time is never negative", () {
    int nowMillis = 1000;
    final chessClock = ChessClock(
      getNowMillis: () => nowMillis,
      timeControlMillis: 5000,
      incrementsMillis: 1000,
    );

    chessClock.start();
    nowMillis += 6000;
    expect(chessClock.getAvailableMillis(), equals(0));
  });

  test("time is not ticking when it's up", () {
    int nowMillis = 1000;
    final chessClock = ChessClock(
      getNowMillis: () => nowMillis,
      timeControlMillis: 5000,
      incrementsMillis: 1000,
    );

    chessClock.start();
    nowMillis += 6000;
    expect(chessClock.isTicking(), equals(false));
  });
}
