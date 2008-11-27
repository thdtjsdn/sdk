////////////////////////////////////////////////////////////////////////////////
//
//  OpenZoom
//
//  Copyright (c) 2008, Daniel Gasienica <daniel@gasienica.ch>
//
//  OpenZoom is free software: you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published by
//  the Free Software Foundation, either version 3 of the License, or
//  (at your option) any later version.
//
//  OpenZoom is distributed in the hope that it will be useful,
//  but WITHOUT ANY WARRANTY; without even the implied warranty of
//  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//  GNU General Public License for more details.
//
//  You should have received a copy of the GNU General Public License
//  along with OpenZoom. If not, see <http://www.gnu.org/licenses/>.
//
////////////////////////////////////////////////////////////////////////////////
package org.openzoom.flash.viewport.transformers
{

import caurina.transitions.Tweener;

import org.openzoom.flash.viewport.INormalizedViewport;
import org.openzoom.flash.viewport.IViewportTransform;
import org.openzoom.flash.viewport.IViewportTransformationTarget;
import org.openzoom.flash.viewport.IViewportTransformer;
    
public class TweenerTransformer implements IViewportTransformer
{
    //--------------------------------------------------------------------------
    //
    //  Class constants
    //
    //--------------------------------------------------------------------------
    
    private static const DEFAULT_DURATION : Number = 2.0
    private static const DEFAULT_EASING : String = "easeOutExpo"
    
    //--------------------------------------------------------------------------
    //
    //  Constructor
    //
    //--------------------------------------------------------------------------
    
    /**
     * Constructor.
     */
    public function TweenerTransformer()
    {
    } 
    
    //--------------------------------------------------------------------------
    //
    //  Methods: IViewportTransformer
    //
    //--------------------------------------------------------------------------
    
    public function transform( viewport : INormalizedViewport,
                               target : IViewportTransformationTarget,
                               targetTransform : IViewportTransform,
                               immediately : Boolean = false ) : void
    {
        var newWidth   : Number = viewport.viewportWidth / viewport.width
        var newHeight  : Number = viewport.viewportHeight / viewport.height
        var newX       : Number = -viewport.x * newWidth
        var newY       : Number = -viewport.y * newHeight
        
        if( immediately )
        {
        	// FIXME
        	Tweener.removeAllTweens()
	        viewport.beginTransform()
	        target.x = newX
	        target.y = newY
	        target.width = newWidth
	        target.height = newHeight
	        viewport.endTransform()
        }
        else
        {
	        Tweener.addTween( 
	                          target,
	                          {
                                  x: newX,
	                              y: newY,
	                              width: newWidth,
	                              height: newHeight,
	                              time: DEFAULT_DURATION,
	                              transition: DEFAULT_EASING,
	                              onStart: viewport.beginTransform,
	                              onComplete: viewport.endTransform
	                          }
	                        )
        }
        
    }
}

}