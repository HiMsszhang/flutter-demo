import 'dart:io';
import 'package:path_provider/path_provider.dart';

abstract class CacheUtil {
  // 获取缓存大小
  static Future<String> getSize() async {
    try {
      Directory tempDir = await getTemporaryDirectory();
      double value = await _getTotalSizeOfFilesInDir(tempDir);
      return _renderSize(value);
    } catch (err) {
      return '';
    }
  }

  // 清除缓存
  static Future<bool> clean() async {
    try {
      Directory tempDir = await getTemporaryDirectory();
      return await delDir(tempDir);
    } catch (e) {
      return false;
    }
  }

  ///递归方式删除目录
  static Future<bool> delDir(FileSystemEntity file) async {
    try {
      if (file is Directory) {
        final List<FileSystemEntity> children = file.listSync();
        for (final FileSystemEntity child in children) {
          await delDir(child);
        }
      }
      await file.delete();
      return true;
    } catch (e) {
      return false;
    }
  }

  ///格式化文件大小
  static String _renderSize(double value) {
    if (null == value) {
      return '0';
    }
    List<String> unitArr = List()..add('B')..add('K')..add('M')..add('G');
    int index = 0;
    while (value > 1024) {
      index++;
      value = value / 1024;
    }
    String size = value.toStringAsFixed(2);
    return size + unitArr[index];
  }

  /// 递归方式 计算文件的大小
  static Future<double> _getTotalSizeOfFilesInDir(final FileSystemEntity file) async {
    try {
      if (file is File) {
        int length = await file.length();
        return double.parse(length.toString());
      }
      if (file is Directory) {
        final List<FileSystemEntity> children = file.listSync();
        double total = 0;
        if (children != null) for (final FileSystemEntity child in children) total += await _getTotalSizeOfFilesInDir(child);
        return total;
      }
      return 0;
    } catch (e) {
      return 0;
    }
  }
}
