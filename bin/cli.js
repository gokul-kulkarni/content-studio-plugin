#!/usr/bin/env node
'use strict';

const fs = require('fs');
const path = require('path');
const os = require('os');

function main() {
  const packageRoot = path.resolve(__dirname, '..');
  const sourcePluginDir = path.join(packageRoot, '.claude-plugin');
  const sourceSkillsDir = path.join(packageRoot, 'skills');
  const sourceManifest = path.join(sourcePluginDir, 'plugin.json');

  if (!fs.existsSync(sourceManifest) || !fs.existsSync(sourceSkillsDir)) {
    console.error('content-studio-plugin: package is missing .claude-plugin/ or skills/ — corrupt install?');
    process.exit(1);
  }

  const newVersion = JSON.parse(fs.readFileSync(sourceManifest, 'utf8')).version;

  const skillsRoot = path.join(os.homedir(), '.claude', 'skills');
  const targetRoot = path.join(skillsRoot, 'content-studio');
  const targetPluginDir = path.join(targetRoot, '.claude-plugin');
  const targetSkillsDir = path.join(targetRoot, 'skills');
  const targetManifest = path.join(targetPluginDir, 'plugin.json');

  let previousVersion = null;
  if (fs.existsSync(targetManifest)) {
    try {
      previousVersion = JSON.parse(fs.readFileSync(targetManifest, 'utf8')).version;
    } catch {
      previousVersion = 'unknown';
    }
  }

  fs.mkdirSync(skillsRoot, { recursive: true });

  // Remove-then-recopy so a plugin version that renames/removes a skill
  // folder doesn't leave orphaned files behind in the installed copy.
  fs.rmSync(targetRoot, { recursive: true, force: true });
  fs.mkdirSync(targetRoot, { recursive: true });

  fs.cpSync(sourcePluginDir, targetPluginDir, { recursive: true });
  fs.cpSync(sourceSkillsDir, targetSkillsDir, { recursive: true });

  if (previousVersion && previousVersion !== newVersion) {
    console.log(`Upgrading content-studio from ${previousVersion} to ${newVersion}...`);
  } else if (previousVersion === newVersion) {
    console.log(`Reinstalling content-studio ${newVersion} (already up to date)...`);
  } else {
    console.log(`Installing content-studio ${newVersion}...`);
  }

  console.log('');
  console.log(`Installed -> ${targetRoot}`);
  console.log('');
  console.log('Restart Claude Code (or start a new session) to load it —');
  console.log('it auto-loads as content-studio@skills-dir.');
  console.log('');
  console.log(`To remove it later: rm -rf "${targetRoot}"`);
}

try {
  main();
} catch (err) {
  console.error('content-studio-plugin install failed:', err.message);
  process.exit(1);
}
