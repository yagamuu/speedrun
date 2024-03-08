﻿using Game;
using MelonLoader;
using UnityEngine;

namespace DFZForceFangEquipMod
{
    internal class GUI
    {
        private static string drawText = string.Format("{0} v{1}", new object[]
        {
            DFZForceFangEquipMod.BuildInfo.Name,
            DFZForceFangEquipMod.BuildInfo.Version
        });

        public static void init()
        {
            MelonEvents.OnGUI.Subscribe(DrawMenu, 100);
        }
        public static void executeOnLateUpdate()
        {
            updateDrawText();
        }

        private static void DrawMenu()
        {
            GUIStyle style = UnityEngine.GUI.skin.box;
            style.alignment = TextAnchor.UpperLeft;
            UnityEngine.GUI.Box(new Rect(10, Screen.height - 80, 300, 40), drawText, style);
        }

        private static void updateDrawText()
        {
            GameScene gameScene = GameObject.Find("GameScene")?.GetComponent<GameScene>();
            if (!gameScene || gameScene.Field == null || gameScene.Field.Player == null)
            {
                return;
            }

            if (Settings.enableEquipFangToRandom.Value)
            {
                drawText = string.Format("{0} v{1}\n次回のファング装備先:???", new object[]
                    {
                        DFZForceFangEquipMod.BuildInfo.Name,
                        DFZForceFangEquipMod.BuildInfo.Version
                    }
                );
                return;
            }

            Character player = gameScene.Field?.Player;
            int targetIndex = FangManagement.getTargetIndex(gameScene);
            Item nextFang = player.PlayerInfo.Fangs[targetIndex];

            string displayFangName = nextFang == null ? "なし" : nextFang.DisplayName(gameScene.Field);
            drawText = string.Format("{0} v{1}\n次回のファング装備先:{2}({3})", new object[]
                {
                    DFZForceFangEquipMod.BuildInfo.Name,
                    DFZForceFangEquipMod.BuildInfo.Version,
                    targetIndex + 1,
                    displayFangName
                }
            );
        }
    }
}
