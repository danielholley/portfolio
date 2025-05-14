import React, { useEffect, useState } from 'react';
import { ArrowDown } from 'lucide-react';

export const Hero: React.FC = () => {
  const [typedText, setTypedText] = useState('');
  const fullText = "I'm a Developer, Designer & Creator";
  const [showCursor, setShowCursor] = useState(true);

  useEffect(() => {
    let i = 0;
    const typingInterval = setInterval(() => {
      if (i < fullText.length) {
        setTypedText(fullText.substring(0, i + 1));
        i++;
      } else {
        clearInterval(typingInterval);
        // Keep the cursor blinking after typing is complete
        const blinkInterval = setInterval(() => {
          setShowCursor(prev => !prev);
        }, 500);
        return () => clearInterval(blinkInterval);
      }
    }, 100);

    // Cursor blinking during typing
    const blinkInterval = setInterval(() => {
      setShowCursor(prev => !prev);
    }, 500);

    return () => {
      clearInterval(typingInterval);
      clearInterval(blinkInterval);
    };
  }, []);

  return (
    <section className="min-h-screen flex flex-col justify-center items-center px-4 pt-16">
      <div className="max-w-4xl mx-auto text-center">
        <h1 className="text-4xl sm:text-5xl md:text-6xl font-bold mb-6 animate-fade-in">
          <span className="block">Hello, I'm</span>
          <span className="bg-gradient-to-r from-blue-500 via-purple-500 to-teal-500 bg-clip-text text-transparent">
            Daniel Holley
          </span>
        </h1>
        <h2 className="text-xl sm:text-2xl md:text-3xl font-medium text-gray-700 dark:text-gray-300 mb-8 h-10">
          {typedText}
          <span className={`${showCursor ? 'opacity-100' : 'opacity-0'} transition-opacity`}>|</span>
        </h2>
        <p className="text-lg sm:text-xl text-gray-600 dark:text-gray-400 max-w-2xl mx-auto mb-12 animate-fade-in-delay">
          Passionate about creating elegant solutions to complex problems. I blend creativity with technical expertise to build beautiful, functional digital experiences.
        </p>
        <div className="flex flex-wrap justify-center gap-4 mb-16 animate-fade-in-delay-longer">
          <a
            href="#contact"
            className="px-8 py-3 rounded-full bg-blue-600 hover:bg-blue-700 text-white font-medium transition-all duration-300 transform hover:translate-y-[-2px] hover:shadow-lg"
          >
            Contact Me
          </a>
          <a
            href="#projects"
            className="px-8 py-3 rounded-full bg-transparent border-2 border-blue-600 dark:border-blue-500 text-blue-600 dark:text-blue-500 font-medium hover:bg-blue-50 dark:hover:bg-gray-800 transition-all duration-300 transform hover:translate-y-[-2px] hover:shadow-lg"
          >
            View Projects
          </a>
        </div>
      </div>
      <a 
        href="#about" 
        className="absolute bottom-8 animate-bounce"
        aria-label="Scroll down"
      >
        <ArrowDown className="text-gray-600 dark:text-gray-400" />
      </a>
    </section>
  );
};