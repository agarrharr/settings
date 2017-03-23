module.exports = {
  config: {
    fontSize: 12,
    fontFamily: 'Menlo, "DejaVu Sans Mono", "Lucida Console", monospace',
    padding: '12px 14px',
    summonShortcut: 'Alt+Space',
    modifierKeys: {
      altIsMeta: true
    }
  },
  plugins: [
    'nova-hyperterm',
    'hyperterm-summon',
    'hyper-hide-title'
  ]
};
