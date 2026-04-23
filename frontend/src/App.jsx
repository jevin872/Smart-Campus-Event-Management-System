import { useState } from 'react'
import { motion } from 'framer-motion'
import { Calendar, Users, Shield, Ticket, Bell, CheckCircle } from 'lucide-react'

function App() {
  const [activeTab, setActiveTab] = useState('events')

  const features = [
    { icon: <Calendar className="w-6 h-6 text-indigo-400" />, title: "Smart Scheduling", desc: "AI-powered conflict resolution and campus venue management." },
    { icon: <Shield className="w-6 h-6 text-rose-400" />, title: "Secure Access", desc: "Role-based control with JWT stateless authentication." },
    { icon: <Ticket className="w-6 h-6 text-cyan-400" />, title: "Digital Ticketing", desc: "Dynamic QR code generation and real-time validation." },
  ]

  return (
    <div className="min-h-screen pb-20">
      <nav>
        <div className="container">
          <div className="flex items-center gap-2">
            <div className="w-8 h-8 rounded-lg bg-gradient-to-tr from-indigo-500 to-cyan-400 flex items-center justify-center font-bold">C</div>
            <span className="font-bold tracking-tight text-xl">CampusConnect</span>
          </div>
          <div className="flex gap-4">
            <button className="btn btn-outline text-sm py-2">Sign In</button>
            <button className="btn btn-primary text-sm py-2">Get Started</button>
          </div>
        </div>
      </nav>

      <main className="container mt-20">
        <div className="grid md:grid-cols-2 gap-12 items-center">
          <motion.div 
            initial={{ opacity: 0, y: 20 }}
            animate={{ opacity: 1, y: 0 }}
            transition={{ duration: 0.5 }}
          >
            <div className="inline-block px-3 py-1 mb-6 text-xs font-semibold tracking-wide text-cyan-300 uppercase bg-cyan-900/30 rounded-full border border-cyan-800/50">
              V2.0 is now live
            </div>
            <h1 className="text-5xl md:text-7xl font-extrabold mb-6 leading-tight">
              Next-Gen <br/>
              <span className="gradient-text">Campus Events</span>
            </h1>
            <p className="text-lg text-slate-400 mb-8 max-w-lg leading-relaxed">
              Experience the highest fidelity event management platform designed specifically for modern smart campuses. Powered by Spring Boot and React.
            </p>
            <div className="flex gap-4">
              <button className="btn btn-primary">Browse Events</button>
              <button className="btn btn-outline">Organizer Hub</button>
            </div>
            
            <div className="mt-12 flex gap-8">
              <div>
                <h4 className="text-3xl font-bold text-white">4.2k+</h4>
                <p className="text-sm text-slate-500">Active Students</p>
              </div>
              <div>
                <h4 className="text-3xl font-bold text-white">150+</h4>
                <p className="text-sm text-slate-500">Events Weekly</p>
              </div>
            </div>
          </motion.div>

          <motion.div
            initial={{ opacity: 0, scale: 0.95 }}
            animate={{ opacity: 1, scale: 1 }}
            transition={{ duration: 0.6, delay: 0.2 }}
            className="relative"
          >
            <div className="absolute inset-0 bg-gradient-to-tr from-indigo-500/20 to-cyan-500/20 blur-3xl -z-10 rounded-full"></div>
            <div className="glass-card flex flex-col gap-6">
              <div className="flex justify-between items-center border-b border-white/10 pb-4">
                <h3 className="text-xl font-bold">Upcoming Highlights</h3>
                <span className="text-xs text-indigo-400 font-medium bg-indigo-500/10 px-2 py-1 rounded">View all</span>
              </div>
              
              {[1, 2, 3].map((_, i) => (
                <div key={i} className="flex gap-4 items-center group cursor-pointer p-2 rounded-lg hover:bg-white/5 transition-colors">
                  <div className="w-12 h-12 rounded-lg bg-slate-800 border border-slate-700 flex flex-col items-center justify-center flex-shrink-0 group-hover:border-indigo-500/50 transition-colors">
                    <span className="text-xs text-slate-400 uppercase font-semibold">APR</span>
                    <span className="font-bold text-indigo-300">1{4+i}</span>
                  </div>
                  <div>
                    <h4 className="font-semibold text-slate-200 group-hover:text-white transition-colors">{["Tech Symposium 2026", "Spring Music Fest", "Alumni Networking"][i]}</h4>
                    <p className="text-sm text-slate-500 flex items-center gap-1 mt-1">
                      <Users className="w-3 h-3"/> {["450", "1200", "200"][i]} attending
                    </p>
                  </div>
                  <button className="ml-auto w-8 h-8 rounded-full border border-slate-700 flex items-center justify-center text-slate-400 group-hover:bg-indigo-500 group-hover:text-white group-hover:border-indigo-400 transition-all">
                    +
                  </button>
                </div>
              ))}
            </div>
          </motion.div>
        </div>

        <div className="mt-32">
          <div className="text-center mb-16">
            <h2 className="text-3xl md:text-4xl font-bold mb-4">Enterprise-grade Features</h2>
            <p className="text-slate-400 max-w-2xl mx-auto">Built with security and performance in mind, our platform handles thousands of concurrent registrations effortlessly.</p>
          </div>
          
          <div className="grid md:grid-cols-3 gap-6">
            {features.map((feature, idx) => (
              <motion.div 
                key={idx}
                whileHover={{ y: -5 }}
                className="glass p-8 rounded-2xl border border-slate-800 hover:border-slate-700 transition-colors"
              >
                <div className="w-12 h-12 rounded-xl bg-slate-800/50 flex items-center justify-center mb-6">
                  {feature.icon}
                </div>
                <h3 className="text-xl font-semibold mb-3">{feature.title}</h3>
                <p className="text-slate-400 text-sm leading-relaxed">{feature.desc}</p>
              </motion.div>
            ))}
          </div>
        </div>
      </main>
    </div>
  )
}

export default App
