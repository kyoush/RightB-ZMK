# RightB ZMK

RightB keyboardのZMK Firmware開発リポジトリです。

ハードウェアの設計・PCBなどは別リポジトリで管理しています。

* [RightB Hardware](https://github.com/kyoush/RightB)

## Firmware仕様

| 機能                         | 状態      |
| -------------------------- | ------- |
| ZMK Firmware               | ✅ 対応    |
| XIAO nRF52840              | ✅ 対応    |
| キーマップ                      | ✅ 対応    |
| Bluetooth Low Energy (BLE) | ✅ 対応    |
| USB HID                    | ✅ 対応    |
| ZMK Studio                 | ✅ 対応    |
| ロータリーエンコーダー                | ✅ 対応    |
| XIAO BLE内蔵RGB LED          | ✅ 対応    |
| LEDストリップ                   | ✅ 対応    |
| BLE接続状態表示                  | ✅ 対応    |
| バッテリー駆動                    | 🚧 次期対応 |
| バッテリー残量表示                  | 🚧 次期対応 |

## 開発環境

Dockerを使用してZMKの開発環境を構築しています。

ZMK本体のworkspaceはDocker volume上に配置し、このリポジトリの設定とは分離しています。

### セットアップ

初回セットアップ、およびZMK workspaceの更新：

```bash
./setup.sh
```

ZMK CLIを使用してworkspaceを初期化し、`config/west.yml` に定義されたmoduleを取得します。

現在使用している追加module：

* [zmk-rgbled-widget](https://github.com/caksoylar/zmk-rgbled-widget)

## ビルド

通常のビルド：

```bash
./build.sh
```

pristine build：

```bash
./build.sh -p always
```

生成されたファームウェア：

```text
build/zephyr/zmk.uf2
```

ローカルビルドでは以下の構成を使用します。

```text
Board:
xiao_ble/nrf52840/zmk

Shield:
rightb
rgbled_adapter
```

## ZMK Studio

ZMK Studioを使用できる構成にしています。

ローカルビルドでは `studio-rpc-usb-uart` snippetを有効にしています。

```text
-S studio-rpc-usb-uart
```

ZMKの設定ファイルは `config/` で管理しています。

## RGB LED

XIAO BLEの内蔵RGB LEDをステータスインジケータとして使用しています。

`zmk-rgbled-widget` の `rgbled_adapter` shieldを使用し、バッテリー残量とBLE接続状態を表示します。

デフォルトの起動時表示について、実機で動作確認済みです。

```text
緑 → 青 → 消灯
```

## GitHub Actions

GitHub Actionsでは、ZMKのreusable workflowを使用しています。

```yaml
jobs:
  build:
    uses: zmkfirmware/zmk/.github/workflows/build-user-config.yml@v0.3
```

ビルド対象は `build.yaml` で定義しています。

```yaml
include:
  - board: xiao_ble/nrf52840/zmk
    shield: rightb rgbled_adapter
    artifact-name: rightb
```

`artifact-name` は、qualified board名に含まれる `/` や複数shieldによる成果物パスの問題を避けるため明示しています。

## リポジトリ構成

```text
.
├── boards/                 # RightB固有のZMK設定
├── config/                 # ZMK設定・west manifest
├── docker/                 # Docker開発環境
├── .github/
│   └── workflows/          # GitHub Actions
├── build.sh                # ローカルビルド
├── build.yaml              # CIビルド設定
├── compose.yaml            # Docker Compose設定
└── setup.sh                # ZMK workspaceのセットアップ・更新
```

## 開発メモ

このREADMEは製品向けのドキュメントではなく、RightB Firmwareの開発環境と現在の構成を後から確認できるようにするための開発記録です。

ハードウェア設計については、[RightB Hardware](https://github.com/kyoush/RightB)を参照してください。
