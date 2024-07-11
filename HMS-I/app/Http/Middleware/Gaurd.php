<?php

namespace App\Http\Middleware;

use Closure;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Symfony\Component\HttpFoundation\Response;

class Gaurd
{
    /**
     * Handle an incoming request.
     *
     * @param  \Closure(\Illuminate\Http\Request): (\Symfony\Component\HttpFoundation\Response)  $next
     */
    // public function handle(Request $request, Closure $next): Response
    // {
    //     if (auth()->user() && auth()->user()->role =='Doctor' ){
    //     return $next($request);}
    //     return redirect('/');
    // }
    public function handle(Request $request, Closure $next)
    {
        $user = Auth::user();
        
        // Check if the user is authenticated and has either the 'doctor' or 'patient' role
        if ($user && in_array($user->role, ['Doctor', 'Patient'])) {
            return $next($request);
        }
        
        return redirect()->route('authlogin'); // Adjust the route name based on your application
    }

}
