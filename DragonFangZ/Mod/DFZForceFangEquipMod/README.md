# DFZ Force Equipment Fang Mod
ドラゴンファングZにおける縛りプレイ用のModです。  
ファングが落ちる度に強制的に順番に装備します。  

## 使い方
1. MelonLoaderのインストーラーを[ダウンロードする](https://github.com/LavaGang/MelonLoader.Installer/releases/latest/download/MelonLoader.Installer.exe)

2. ダウンロードしたインストーラーを起動し、`Unity Game:`の横の`SELECT`ボタンを押し、ドラゴンファングZのexeファイルを選択する(インストール先はSteam内でプロパティ→ローカルファイルを閲覧などで確認できる)

3. Version横の`Latest`チェックマークを外し、`v0.5.7`を選択する

4. 一番下の`INSTALL`ボタンを押す

5. ゲームフォルダ内のModsフォルダに[`DFZForceFangEquipMod.dll`](https://github.com/yagamuu/speedrun/blob/master/DragonFangZ/Mod/DFZForceFangEquipMod/DFZForceFangEquipMod.dll)を入れる

6. 希望に応じてオプションを変更してください
    1. ゲームフォルダ内の`UserData\MelonPreferences.cfg`をテキストエディタで開き書き換えることで変更可能です。
    2. よくわからない人は[`MelonPrefManager.Mono.dll`](https://github.com/yagamuu/speedrun/blob/master/DragonFangZ/Mod/DFZForceFangEquipMod/MelonPrefManager.Mono.dll)と[`UniverseLib.Mono.dll`](https://github.com/yagamuu/speedrun/blob/master/DragonFangZ/Mod/DFZForceFangEquipMod/UniverseLib.Mono.dll)をModsフォルダに入れてF5キーを押して設定してください(From [MelonPreferencesManager](https://github.com/kafeijao/MelonPreferencesManager))。

### オプションの指定例
```
[dfzForceFangEquipMod]
# ファングの装着コマンドを有効化するか(false:しない、true:する)
enableEquipFangAction = false
# 薬によるファングドロップ確定化を無効化する(false:しない、true:する)
disableFang100FromItem = true
# オブジェクトによるファングドロップ確定化を無効化する(false:しない、true:する)
disableFang100FromObj = false
# 特定攻撃(戦乙女サクリなど)によるファングドロップ率増加を無効化する(false:しない、true:する)
disableFangDropRate = false
# 強制装備を無効化するファングを指定(複数指定する場合は","で区切ってください)
disableFangDropMonsters = "キョンシーロック,ケルベロス"
```

## 変更ログ
- v1.0.6
  - GUIの表示を右下に変更(左下は足元コマンドと被るため)
  - 竜石を投げた時の確定ドロップ効果の有効化無効化オプションを実装
- v1.0.5
  - 転んで装備中のファングを落とした際に強制装備を実行するオプションを追加
  - 強制装備時に空白のファング枠に優先して装備を行うオプションを追加
  - 地雷/カエルスキルで倒した敵がファングを落とした際に強制装備を行うオプションを追加
  - 薬によるファングドロップ確定化を無効化している際未識別の確定ドロップ薬を投げても識別されない不具合を修正
  - ファングを購入した場合に強制装備を行うか選択するオプションを追加
    - これに合わせファング購入時の挙動を修正
  - 強制装備を行うファング枠をランダムにするオプションを追加
- v1.0.4
  - 強制装備時にブレイブをリセットするか選択するオプションを追加
  - 強制装備を無視するファング指定のオプションが空の場合強制装備が一切機能しなくなる致命的な不具合を修正
- v1.0.3
  - 強制装備を無視するファングを指定するオプションを実装(指定した名前を含むファングを全て無視します、複数指定する場合は","で区切ってください 例: `キョンシーロック,ケルベロス,爆轟ガエル`)
- v1.0.2
  - 各種ファングドロップ率操作の有効化無効化オプションを実装(薬、竜脈、戦乙女など)
  - ファングの装着コマンドを無効化するオプションを復活(有効に呪いと同じようにターンを消費して弾かれるようになった)
- v1.0.1
  - 毒のダメージでモンスターを撃破しファングを落とした際に強制装備が発生しない不具合修正
  - ファングの装着コマンド削除を一時的に廃止(別の方法で実現する予定)
- v1.0.0
  - 初版リリース