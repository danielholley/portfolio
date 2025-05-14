import React from 'react';
import { useInView } from '../hooks/useInView';
import { skillsData } from '../data/skillsData';

export const Skills: React.FC = () => {
  const { ref, inView } = useInView({ threshold: 0.1 });

  return (
    <section id="skills" className="py-20 px-4 bg-gray-100 dark:bg-gray-800/50">
      <div 
        ref={ref}
        className={`max-w-6xl mx-auto transition-all duration-1000 transform ${
          inView ? 'opacity-100 translate-y-0' : 'opacity-0 translate-y-10'
        }`}
      >
        <h2 className="text-3xl md:text-4xl font-bold mb-12 text-center">
          <span className="bg-gradient-to-r from-blue-500 to-teal-500 bg-clip-text text-transparent">
            My Skills
          </span>
        </h2>
        
        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-8">
          {skillsData.map((category, index) => (
            <div 
              key={category.title}
              className={`bg-white dark:bg-gray-900 rounded-xl p-6 shadow-md transition-all duration-500 transform hover:shadow-lg hover:translate-y-[-5px] animate-fade-in`}
              style={{ animationDelay: `${index * 150}ms` }}
            >
              <h3 className="text-xl font-bold mb-4 text-blue-600 dark:text-blue-400">
                {category.title}
              </h3>
              <div className="space-y-3">
                {category.skills.map(skill => (
                  <div key={skill.name}>
                    <div className="flex justify-between items-center mb-1">
                      <span className="text-sm font-medium">{skill.name}</span>
                      <span className="text-xs text-gray-500 dark:text-gray-400">{skill.level}%</span>
                    </div>
                    <div className="w-full bg-gray-200 dark:bg-gray-700 rounded-full h-2.5">
                      <div 
                        className="bg-gradient-to-r from-blue-500 to-purple-600 h-2.5 rounded-full transition-all duration-1000 ease-out"
                        style={{ width: inView ? `${skill.level}%` : '0%' }}
                      ></div>
                    </div>
                  </div>
                ))}
              </div>
            </div>
          ))}
        </div>
      </div>
    </section>
  );
};