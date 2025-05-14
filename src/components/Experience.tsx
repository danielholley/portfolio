import React from 'react';
import { useInView } from '../hooks/useInView';
import { experienceData } from '../data/experienceData';
import { Briefcase, Calendar } from 'lucide-react';

export const Experience: React.FC = () => {
  const { ref, inView } = useInView({ threshold: 0.1 });

  return (
    <section id="experience" className="py-20 px-4 bg-gray-100 dark:bg-gray-800/50">
      <div 
        ref={ref}
        className={`max-w-6xl mx-auto transition-all duration-1000 transform ${
          inView ? 'opacity-100 translate-y-0' : 'opacity-0 translate-y-10'
        }`}
      >
        <h2 className="text-3xl md:text-4xl font-bold mb-12 text-center">
          <span className="bg-gradient-to-r from-blue-500 to-teal-500 bg-clip-text text-transparent">
            Work Experience
          </span>
        </h2>
        
        <div className="relative">
          {/* Timeline line */}
          <div className="absolute left-0 md:left-1/2 transform md:translate-x-[-50%] h-full w-1 bg-blue-200 dark:bg-blue-900"></div>
          
          {/* Experience items */}
          <div className="space-y-12">
            {experienceData.map((job, index) => (
              <div 
                key={index}
                className={`relative ${index % 2 === 0 ? 'md:ml-auto md:pr-0 md:pl-8' : 'md:mr-auto md:pl-0 md:pr-8'} ml-8 pl-8 md:w-[calc(50%-2rem)]`}
                style={{ 
                  opacity: inView ? 1 : 0, 
                  transform: inView ? 'translateY(0)' : 'translateY(30px)',
                  transition: `opacity 0.5s ease ${index * 0.2}s, transform 0.5s ease ${index * 0.2}s` 
                }}
              >
                {/* Timeline dot */}
                <div className="absolute left-[-8px] md:left-[calc(50%-40px)] top-0 w-4 h-4 rounded-full bg-blue-500 border-4 border-white dark:border-gray-800 z-10"></div>
                
                {/* Content card */}
                <div className="bg-white dark:bg-gray-900 rounded-lg p-6 shadow-md hover:shadow-lg transition-shadow duration-300">
                  <div className="flex items-center gap-2 text-blue-600 dark:text-blue-400 mb-2">
                    <Briefcase size={16} />
                    <h3 className="text-lg font-bold">{job.company}</h3>
                  </div>
                  <h4 className="text-xl font-semibold mb-1">{job.position}</h4>
                  <div className="flex items-center gap-1 text-gray-500 dark:text-gray-400 text-sm mb-4">
                    <Calendar size={14} />
                    <span>{job.period}</span>
                  </div>
                  <ul className="list-disc list-inside space-y-2 text-gray-700 dark:text-gray-300">
                    {job.responsibilities.map((item, i) => (
                      <li key={i}>{item}</li>
                    ))}
                  </ul>
                </div>
              </div>
            ))}
          </div>
        </div>
      </div>
    </section>
  );
};