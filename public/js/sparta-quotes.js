var sparta = sparta || {};

/**
 * Generate a random quote.
 *
 * @return {String} A random quote.
 */
sparta.quote = function() {
  var quotes = [
    "A thousand nations of the Persian empire will descend upon you. Our dashboards will blot out the sun!",
    "You have many metrics, Xerxes, but few insights.",
    "A new age has begun. An age of data, and all will know that 300 Spartans gave their last breath to defend it.",
    "We did what we were trained to do, what we were bred to do, what we were born to do. Measure!",
    "We are with you, sire! For A/B testing, for freedom, to the death!",
    "When the experiment was launched, like all Spartans, it was inspected.",
    "'Trust the gods, Leonidas.' 'I'd prefer you trusted your metrics.'"
  ];

  var randomIndex = Math.floor(Math.random() * quotes.length);
  return quotes[randomIndex];
};