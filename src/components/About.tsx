import React, { useEffect } from 'react';
import { useInView } from '../hooks/useInView';

export const About: React.FC = () => {
  const { ref, inView } = useInView({ threshold: 0.2 });

  return (
    <section id="about" className="py-20 px-4">
      <div 
        ref={ref}
        className={`max-w-6xl mx-auto transition-all duration-1000 transform ${
          inView ? 'opacity-100 translate-y-0' : 'opacity-0 translate-y-10'
        }`}
      >
        <h2 className="text-3xl md:text-4xl font-bold mb-12 text-center">
          <span className="bg-gradient-to-r from-blue-500 to-teal-500 bg-clip-text text-transparent">
            About Me
          </span>
        </h2>
        
        <div className="grid grid-cols-1 md:grid-cols-2 gap-12 items-center">
          <div className="aspect-square rounded-2xl overflow-hidden shadow-xl transform hover:rotate-2 transition-all duration-500">
            <img 
              src="https://images.pexels.com/photos/7709018/pexels-photo-7709018.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2" 
              alt="Professional profile" 
              className="w-full h-full object-cover"
            />
          </div>
          
          <div className="space-y-6">
            <h3 className="text-2xl font-bold">Who I Am</h3>
            <p className="text-lg text-gray-700 dark:text-gray-300 leading-relaxed">
              I'm a passionate developer and designer with a love for creating intuitive, user-focused digital experiences. With a background in both design and development, I bring a unique perspective to every project.
            </p>
            
            <p className="text-lg text-gray-700 dark:text-gray-300 leading-relaxed">
              My journey in tech began over 25 years ago, and I've been constantly learning and evolving my skills. I believe in clean code, thoughtful design, and creating solutions that make a difference.
            </p>
            
            <p className="text-lg text-gray-700 dark:text-gray-300 leading-relaxed">
              When I'm not coding, you'll find me hiking in the mountains, experimenting with photography, or exploring new coffee shops in the city.
            </p>
            
            <div className="pt-4">
              <a 
                href="/resume.pdf" 
                className="inline-flex items-center gap-2 px-5 py-2 rounded-lg bg-gray-200 dark:bg-gray-800 hover:bg-gray-300 dark:hover:bg-gray-700 transition-colors duration-300"
              >
                Download Resume
              </a>
            </div>
          </div>
        </div>
      </div>
    </section>
  );
};